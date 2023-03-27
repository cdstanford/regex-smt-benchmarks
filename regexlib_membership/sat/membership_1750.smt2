;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\{\\f\d*)\\([^;]+;)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "{\f\\u008F;\u009A"
(define-fun Witness1 () String (str.++ "{" (str.++ "\u{5c}" (str.++ "f" (str.++ "\u{5c}" (str.++ "\u{8f}" (str.++ ";" (str.++ "\u{9a}" ""))))))))
;witness2: "{\f1\\x1E;\u00B0\u00C6"
(define-fun Witness2 () String (str.++ "{" (str.++ "\u{5c}" (str.++ "f" (str.++ "1" (str.++ "\u{5c}" (str.++ "\u{1e}" (str.++ ";" (str.++ "\u{b0}" (str.++ "\u{c6}" ""))))))))))

(assert (= regexA (re.++ (re.++ (str.to_re (str.++ "{" (str.++ "\u{5c}" (str.++ "f" "")))) (re.* (re.range "0" "9")))(re.++ (re.range "\u{5c}" "\u{5c}") (re.++ (re.+ (re.union (re.range "\u{00}" ":") (re.range "<" "\u{ff}"))) (re.range ";" ";"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
