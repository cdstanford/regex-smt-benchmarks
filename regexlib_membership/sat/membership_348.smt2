;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([1-9]{1}[0-9]{0,5}([.]{1}[0-9]{0,2})?)|(([0]{1}))([.]{1}[0-9]{0,2})?)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0.3"
(define-fun Witness1 () String (str.++ "0" (str.++ "." (str.++ "3" ""))))
;witness2: "140.75"
(define-fun Witness2 () String (str.++ "1" (str.++ "4" (str.++ "0" (str.++ "." (str.++ "7" (str.++ "5" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 5) (re.range "0" "9")) (re.opt (re.++ (re.range "." ".") ((_ re.loop 0 2) (re.range "0" "9")))))) (re.++ (re.range "0" "0") (re.opt (re.++ (re.range "." ".") ((_ re.loop 0 2) (re.range "0" "9")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
