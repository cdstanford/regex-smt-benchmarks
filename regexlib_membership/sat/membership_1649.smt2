;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(.|\n){0,16}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0084\x19"
(define-fun Witness1 () String (str.++ "\u{84}" (str.++ "\u{19}" "")))
;witness2: "\u0085\x17"
(define-fun Witness2 () String (str.++ "\u{85}" (str.++ "\u{17}" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 0 16) (re.union (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (re.range "\u{0a}" "\u{0a}"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
