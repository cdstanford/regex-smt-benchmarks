;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (.|[\r\n]){1,5}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+\u0084E\u00F4Z\u00D2"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "\x84" (seq.++ "E" (seq.++ "\xf4" (seq.++ "Z" (seq.++ "\xd2" "")))))))
;witness2: "\x11"
(define-fun Witness2 () String (seq.++ "\x11" ""))

(assert (= regexA ((_ re.loop 1 5) (re.union (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (re.union (re.range "\x0a" "\x0a") (re.range "\x0d" "\x0d"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
