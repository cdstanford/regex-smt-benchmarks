;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s+|\s+$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\xC\u0085"
(define-fun Witness1 () String (str.++ "\u{0c}" (str.++ "\u{85}" "")))
;witness2: "\u00858"
(define-fun Witness2 () String (str.++ "\u{85}" (str.++ "8" "")))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))) (re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
