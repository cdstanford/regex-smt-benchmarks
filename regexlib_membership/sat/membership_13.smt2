;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((((00|\+)49[ \-/]{0,1})|0)[1-9][0-9]{1,4}[ \-/]{0,1}|(((00|\+)49\()|\(0)[1-9][0-9]{1,4}\))[0-9]{1,7}[ \-/]{0,1}[0-9]{1,5})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+49 41889 5 99"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "4" (seq.++ "9" (seq.++ " " (seq.++ "4" (seq.++ "1" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ " " (seq.++ "5" (seq.++ " " (seq.++ "9" (seq.++ "9" "")))))))))))))))
;witness2: "0049(890)6 98"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "0" (seq.++ "4" (seq.++ "9" (seq.++ "(" (seq.++ "8" (seq.++ "9" (seq.++ "0" (seq.++ ")" (seq.++ "6" (seq.++ " " (seq.++ "9" (seq.++ "8" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.++ (re.union (re.++ (re.union (str.to_re (seq.++ "0" (seq.++ "0" ""))) (re.range "+" "+"))(re.++ (str.to_re (seq.++ "4" (seq.++ "9" ""))) (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "/" "/")))))) (re.range "0" "0"))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 1 4) (re.range "0" "9")) (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "/" "/"))))))) (re.++ (re.union (re.++ (re.union (str.to_re (seq.++ "0" (seq.++ "0" ""))) (re.range "+" "+")) (str.to_re (seq.++ "4" (seq.++ "9" (seq.++ "(" ""))))) (str.to_re (seq.++ "(" (seq.++ "0" ""))))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 1 4) (re.range "0" "9")) (re.range ")" ")")))))(re.++ ((_ re.loop 1 7) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "/" "/")))) ((_ re.loop 1 5) (re.range "0" "9"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
