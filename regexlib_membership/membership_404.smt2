;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(.|\r|\n){1,10}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u009D"
(define-fun Witness1 () String (str.++ "\u{9d}" ""))
;witness2: "x\u0083\x1"
(define-fun Witness2 () String (str.++ "x" (str.++ "\u{83}" (str.++ "\u{01}" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 10) (re.union (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (re.union (re.range "\u{0a}" "\u{0a}") (re.range "\u{0d}" "\u{0d}")))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
