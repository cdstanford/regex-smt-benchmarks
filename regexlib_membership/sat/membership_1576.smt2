;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <([^<>\s]*)(\s[^<>]*)?>
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "b<\u00BAL\u0084>"
(define-fun Witness1 () String (str.++ "b" (str.++ "<" (str.++ "\u{ba}" (str.++ "L" (str.++ "\u{84}" (str.++ ">" "")))))))
;witness2: "<\x0A:\u009AL\x9\u00BB\u009E>"
(define-fun Witness2 () String (str.++ "<" (str.++ "\u{00}" (str.++ "A" (str.++ ":" (str.++ "\u{9a}" (str.++ "L" (str.++ "\u{09}" (str.++ "\u{bb}" (str.++ "\u{9e}" (str.++ ">" "")))))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.* (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}"))))))))(re.++ (re.opt (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) (re.* (re.union (re.range "\u{00}" ";")(re.union (re.range "=" "=") (re.range "?" "\u{ff}")))))) (re.range ">" ">"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
