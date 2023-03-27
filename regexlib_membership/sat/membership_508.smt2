;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = if\s[(][A-Za-z]*\s[=]\s
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "if\xD(K\xA= "
(define-fun Witness1 () String (str.++ "i" (str.++ "f" (str.++ "\u{0d}" (str.++ "(" (str.++ "K" (str.++ "\u{0a}" (str.++ "=" (str.++ " " "")))))))))
;witness2: "if (\u00A0=\u0085\u0085"
(define-fun Witness2 () String (str.++ "i" (str.++ "f" (str.++ " " (str.++ "(" (str.++ "\u{a0}" (str.++ "=" (str.++ "\u{85}" (str.++ "\u{85}" "")))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "i" (str.++ "f" "")))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.range "(" "(")(re.++ (re.* (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.range "=" "=") (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
