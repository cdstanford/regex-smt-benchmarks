;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(.|\n){0,16}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0084\x19"
(define-fun Witness1 () String (seq.++ "\x84" (seq.++ "\x19" "")))
;witness2: "\u0085\x17"
(define-fun Witness2 () String (seq.++ "\x85" (seq.++ "\x17" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 0 16) (re.union (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (re.range "\x0a" "\x0a"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
