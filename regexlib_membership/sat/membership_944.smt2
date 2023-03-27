;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d)?[ ]*[\(\.\-]?(\d{3})[\)\.\-]?[ ]*(\d{3})[\.\- ]?(\d{4})[ ]*(x|ext\.?)?[ ]*(\d{1,7})?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "317)9988858   x9"
(define-fun Witness1 () String (str.++ "3" (str.++ "1" (str.++ "7" (str.++ ")" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "5" (str.++ "8" (str.++ " " (str.++ " " (str.++ " " (str.++ "x" (str.++ "9" "")))))))))))))))))
;witness2: "(980-   768-9298  x"
(define-fun Witness2 () String (str.++ "(" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "-" (str.++ " " (str.++ " " (str.++ " " (str.++ "7" (str.++ "6" (str.++ "8" (str.++ "-" (str.++ "9" (str.++ "2" (str.++ "9" (str.++ "8" (str.++ " " (str.++ " " (str.++ "x" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.* (re.range " " " "))(re.++ (re.opt (re.union (re.range "(" "(") (re.range "-" ".")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range ")" ")") (re.range "-" ".")))(re.++ (re.* (re.range " " " "))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" ".")))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.* (re.range " " " "))(re.++ (re.opt (re.union (re.range "x" "x") (re.++ (str.to_re (str.++ "e" (str.++ "x" (str.++ "t" "")))) (re.opt (re.range "." ".")))))(re.++ (re.* (re.range " " " "))(re.++ (re.opt ((_ re.loop 1 7) (re.range "0" "9"))) (str.to_re "")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
