;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\$(\d{1,3},?(\d{3},?)*\d{3}(\.\d{1,3})?|\d{1,3}(\.\d{2})?)$|^\d{1,2}(\.\d{1,2})? *%$|^100%$)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "$4"
(define-fun Witness1 () String (str.++ "$" (str.++ "4" "")))
;witness2: "8 %"
(define-fun Witness2 () String (str.++ "8" (str.++ " " (str.++ "%" ""))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "$" "$")(re.++ (re.union (re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.opt (re.range "," ","))(re.++ (re.* (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range "," ","))))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 3) (re.range "0" "9")))))))) (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.opt (re.++ (re.range "." ".") ((_ re.loop 2 2) (re.range "0" "9")))))) (str.to_re ""))))(re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 2) (re.range "0" "9"))))(re.++ (re.* (re.range " " " "))(re.++ (re.range "%" "%") (str.to_re "")))))) (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "1" (str.++ "0" (str.++ "0" (str.++ "%" ""))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
