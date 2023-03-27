;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\d{1,3},(\d{3},)*\d{3}(\.\d{1,3})?|\d{1,3}(\.\d{3})?)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "6,858,788"
(define-fun Witness1 () String (str.++ "6" (str.++ "," (str.++ "8" (str.++ "5" (str.++ "8" (str.++ "," (str.++ "7" (str.++ "8" (str.++ "8" ""))))))))))
;witness2: "4\x8/23"
(define-fun Witness2 () String (str.++ "4" (str.++ "\u{08}" (str.++ "/" (str.++ "2" (str.++ "3" ""))))))

(assert (= regexA (re.++ (re.union (re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "," ",")(re.++ (re.* (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range "," ",")))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 3) (re.range "0" "9")))))))) (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.opt (re.++ (re.range "." ".") ((_ re.loop 3 3) (re.range "0" "9")))))) (str.to_re ""))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
