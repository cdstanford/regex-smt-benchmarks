;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\(?\d{2,5}\)?)?(\d|-| )?(15((\d|-| ){6,13})))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00F1015988-  18"
(define-fun Witness1 () String (str.++ "\u{f1}" (str.++ "0" (str.++ "1" (str.++ "5" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "-" (str.++ " " (str.++ " " (str.++ "1" (str.++ "8" "")))))))))))))
;witness2: "\x1339863)-150- 9- "
(define-fun Witness2 () String (str.++ "\u{13}" (str.++ "3" (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "3" (str.++ ")" (str.++ "-" (str.++ "1" (str.++ "5" (str.++ "0" (str.++ "-" (str.++ " " (str.++ "9" (str.++ "-" (str.++ " " "")))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.opt (re.range "(" "("))(re.++ ((_ re.loop 2 5) (re.range "0" "9")) (re.opt (re.range ")" ")")))))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "0" "9")))) (re.++ (str.to_re (str.++ "1" (str.++ "5" ""))) ((_ re.loop 6 13) (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
