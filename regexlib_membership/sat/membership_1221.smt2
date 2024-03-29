;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [-+]((0[0-9]|1[0-3]):([03]0|45)|14:00)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-12:00"
(define-fun Witness1 () String (str.++ "-" (str.++ "1" (str.++ "2" (str.++ ":" (str.++ "0" (str.++ "0" "")))))))
;witness2: "\u00A7-09:00e\u00B0$"
(define-fun Witness2 () String (str.++ "\u{a7}" (str.++ "-" (str.++ "0" (str.++ "9" (str.++ ":" (str.++ "0" (str.++ "0" (str.++ "e" (str.++ "\u{b0}" (str.++ "$" "")))))))))))

(assert (= regexA (re.++ (re.union (re.range "+" "+") (re.range "-" "-")) (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1") (re.range "0" "3")))(re.++ (re.range ":" ":") (re.union (re.++ (re.union (re.range "0" "0") (re.range "3" "3")) (re.range "0" "0")) (str.to_re (str.++ "4" (str.++ "5" "")))))) (str.to_re (str.++ "1" (str.++ "4" (str.++ ":" (str.++ "0" (str.++ "0" ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
