;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [-+]((0[0-9]|1[0-3]):([03]0|45)|14:00)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "-12:00"
(define-fun Witness1 () String (seq.++ "-" (seq.++ "1" (seq.++ "2" (seq.++ ":" (seq.++ "0" (seq.++ "0" "")))))))
;witness2: "\u00A7-09:00e\u00B0$"
(define-fun Witness2 () String (seq.++ "\xa7" (seq.++ "-" (seq.++ "0" (seq.++ "9" (seq.++ ":" (seq.++ "0" (seq.++ "0" (seq.++ "e" (seq.++ "\xb0" (seq.++ "$" "")))))))))))

(assert (= regexA (re.++ (re.union (re.range "+" "+") (re.range "-" "-")) (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1") (re.range "0" "3")))(re.++ (re.range ":" ":") (re.union (re.++ (re.union (re.range "0" "0") (re.range "3" "3")) (re.range "0" "0")) (str.to_re (seq.++ "4" (seq.++ "5" "")))))) (str.to_re (seq.++ "1" (seq.++ "4" (seq.++ ":" (seq.++ "0" (seq.++ "0" ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
