;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\(?\d{2,5}\)?)?(\d|-| )?(15((\d|-| ){6,13})))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00F1015988-  18"
(define-fun Witness1 () String (seq.++ "\xf1" (seq.++ "0" (seq.++ "1" (seq.++ "5" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "-" (seq.++ " " (seq.++ " " (seq.++ "1" (seq.++ "8" "")))))))))))))
;witness2: "\x1339863)-150- 9- "
(define-fun Witness2 () String (seq.++ "\x13" (seq.++ "3" (seq.++ "9" (seq.++ "8" (seq.++ "6" (seq.++ "3" (seq.++ ")" (seq.++ "-" (seq.++ "1" (seq.++ "5" (seq.++ "0" (seq.++ "-" (seq.++ " " (seq.++ "9" (seq.++ "-" (seq.++ " " "")))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.opt (re.range "(" "("))(re.++ ((_ re.loop 2 5) (re.range "0" "9")) (re.opt (re.range ")" ")")))))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "0" "9")))) (re.++ (str.to_re (seq.++ "1" (seq.++ "5" ""))) ((_ re.loop 6 13) (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
