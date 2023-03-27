;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [ \t]+$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x9"
(define-fun Witness1 () String (str.++ "\u{09}" ""))
;witness2: "\x9"
(define-fun Witness2 () String (str.++ "\u{09}" ""))

(assert (= regexA (re.++ (re.+ (re.union (re.range "\u{09}" "\u{09}") (re.range " " " "))) (str.to_re ""))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
