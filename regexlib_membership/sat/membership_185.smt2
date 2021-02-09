;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[+-]?\d*(([,.]\d{3})+)?([,.]\d+)?([eE][+-]?\d+)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "-.686E+8"
(define-fun Witness1 () String (seq.++ "-" (seq.++ "." (seq.++ "6" (seq.++ "8" (seq.++ "6" (seq.++ "E" (seq.++ "+" (seq.++ "8" "")))))))))
;witness2: ",039,1E199"
(define-fun Witness2 () String (seq.++ "," (seq.++ "0" (seq.++ "3" (seq.++ "9" (seq.++ "," (seq.++ "1" (seq.++ "E" (seq.++ "1" (seq.++ "9" (seq.++ "9" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.+ (re.++ (re.union (re.range "," ",") (re.range "." ".")) ((_ re.loop 3 3) (re.range "0" "9")))))(re.++ (re.opt (re.++ (re.union (re.range "," ",") (re.range "." ".")) (re.+ (re.range "0" "9"))))(re.++ (re.opt (re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))) (re.+ (re.range "0" "9"))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
