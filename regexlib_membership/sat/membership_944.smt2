;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d)?[ ]*[\(\.\-]?(\d{3})[\)\.\-]?[ ]*(\d{3})[\.\- ]?(\d{4})[ ]*(x|ext\.?)?[ ]*(\d{1,7})?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "317)9988858   x9"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "1" (seq.++ "7" (seq.++ ")" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "5" (seq.++ "8" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "x" (seq.++ "9" "")))))))))))))))))
;witness2: "(980-   768-9298  x"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "-" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "7" (seq.++ "6" (seq.++ "8" (seq.++ "-" (seq.++ "9" (seq.++ "2" (seq.++ "9" (seq.++ "8" (seq.++ " " (seq.++ " " (seq.++ "x" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.* (re.range " " " "))(re.++ (re.opt (re.union (re.range "(" "(") (re.range "-" ".")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range ")" ")") (re.range "-" ".")))(re.++ (re.* (re.range " " " "))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" ".")))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.* (re.range " " " "))(re.++ (re.opt (re.union (re.range "x" "x") (re.++ (str.to_re (seq.++ "e" (seq.++ "x" (seq.++ "t" "")))) (re.opt (re.range "." ".")))))(re.++ (re.* (re.range " " " "))(re.++ (re.opt ((_ re.loop 1 7) (re.range "0" "9"))) (str.to_re "")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
