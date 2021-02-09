;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(1?)(-| ?)(\()?([0-9]{3})(\)|-| |\)-|\) )?([0-9]{3})(-| )?([0-9]{4}|[0-9]{4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "-(2698590288"
(define-fun Witness1 () String (seq.++ "-" (seq.++ "(" (seq.++ "2" (seq.++ "6" (seq.++ "9" (seq.++ "8" (seq.++ "5" (seq.++ "9" (seq.++ "0" (seq.++ "2" (seq.++ "8" (seq.++ "8" "")))))))))))))
;witness2: "14238596676"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "4" (seq.++ "2" (seq.++ "3" (seq.++ "8" (seq.++ "5" (seq.++ "9" (seq.++ "6" (seq.++ "6" (seq.++ "7" (seq.++ "6" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "1" "1"))(re.++ (re.union (re.range "-" "-") (re.opt (re.range " " " ")))(re.++ (re.opt (re.range "(" "("))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.union (re.range " " " ")(re.union (re.range ")" ")") (re.range "-" "-")))(re.union (str.to_re (seq.++ ")" (seq.++ "-" ""))) (str.to_re (seq.++ ")" (seq.++ " " ""))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ (re.union ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 4 4) (re.range "0" "9"))) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
