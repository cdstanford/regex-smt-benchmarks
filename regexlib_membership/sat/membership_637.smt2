;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((([\(]?[2-9]{1}[0-9]{2}[\)]?)|([2-9]{1}[0-9]{2}\.?)){1}[ ]?[2-9]{1}[0-9]{2}[\-\.]{1}[0-9]{4})([ ]?[xX]{1}[ ]?[0-9]{3,4})?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "498336-9099"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "3" (seq.++ "6" (seq.++ "-" (seq.++ "9" (seq.++ "0" (seq.++ "9" (seq.++ "9" ""))))))))))))
;witness2: "(899 878-8980"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ " " (seq.++ "8" (seq.++ "7" (seq.++ "8" (seq.++ "-" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "0" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.++ (re.opt (re.range "(" "("))(re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.opt (re.range ")" ")"))))) (re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.opt (re.range "." ".")))))(re.++ (re.opt (re.range " " " "))(re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" ".") ((_ re.loop 4 4) (re.range "0" "9")))))))(re.++ (re.opt (re.++ (re.opt (re.range " " " "))(re.++ (re.union (re.range "X" "X") (re.range "x" "x"))(re.++ (re.opt (re.range " " " ")) ((_ re.loop 3 4) (re.range "0" "9")))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
