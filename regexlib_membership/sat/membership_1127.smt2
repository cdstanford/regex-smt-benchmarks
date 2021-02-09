;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(.){0,20}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "x\x7K"
(define-fun Witness1 () String (seq.++ "x" (seq.++ "\x07" (seq.++ "K" ""))))
;witness2: "\x117"
(define-fun Witness2 () String (seq.++ "\x11" (seq.++ "7" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 0 20) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
