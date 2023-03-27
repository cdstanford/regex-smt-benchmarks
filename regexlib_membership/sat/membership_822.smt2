;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\{(.+)|^\\(.+)|(\}*)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "{sc\x2"
(define-fun Witness1 () String (str.++ "{" (str.++ "s" (str.++ "c" (str.++ "\u{02}" "")))))
;witness2: "{\x1CXD\u00C0\u00F0"
(define-fun Witness2 () String (str.++ "{" (str.++ "\u{1c}" (str.++ "X" (str.++ "D" (str.++ "\u{c0}" (str.++ "\u{f0}" "")))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "{" "{") (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))))(re.union (re.++ (str.to_re "")(re.++ (re.range "\u{5c}" "\u{5c}") (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))) (re.* (re.range "}" "}"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
