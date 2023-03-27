;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^[A-Za-z])|(\s)([A-Za-z])
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "`\u00A0o\u00EF"
(define-fun Witness1 () String (str.++ "`" (str.++ "\u{a0}" (str.++ "o" (str.++ "\u{ef}" "")))))
;witness2: "\xAKL"
(define-fun Witness2 () String (str.++ "\u{0a}" (str.++ "K" (str.++ "L" ""))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) (re.union (re.range "A" "Z") (re.range "a" "z"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
