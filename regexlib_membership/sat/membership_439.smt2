;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\(")([0-9]*)(\")
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(\"89926\""
(define-fun Witness1 () String (str.++ "(" (str.++ "\u{22}" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "2" (str.++ "6" (str.++ "\u{22}" "")))))))))
;witness2: "(\"\""
(define-fun Witness2 () String (str.++ "(" (str.++ "\u{22}" (str.++ "\u{22}" ""))))

(assert (= regexA (re.++ (str.to_re (str.++ "(" (str.++ "\u{22}" "")))(re.++ (re.* (re.range "0" "9")) (re.range "\u{22}" "\u{22}")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
