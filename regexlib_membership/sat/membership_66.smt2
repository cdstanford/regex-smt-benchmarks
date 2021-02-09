;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \(\d{3}\)\040\d{3}-\d{4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(781) 689-89421\u00F6"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "7" (seq.++ "8" (seq.++ "1" (seq.++ ")" (seq.++ " " (seq.++ "6" (seq.++ "8" (seq.++ "9" (seq.++ "-" (seq.++ "8" (seq.++ "9" (seq.++ "4" (seq.++ "2" (seq.++ "1" (seq.++ "\xf6" "")))))))))))))))))
;witness2: "\x8(258) 898-1014"
(define-fun Witness2 () String (seq.++ "\x08" (seq.++ "(" (seq.++ "2" (seq.++ "5" (seq.++ "8" (seq.++ ")" (seq.++ " " (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "-" (seq.++ "1" (seq.++ "0" (seq.++ "1" (seq.++ "4" ""))))))))))))))))

(assert (= regexA (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (str.to_re (seq.++ ")" (seq.++ " " "")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
