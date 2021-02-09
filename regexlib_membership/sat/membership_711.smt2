;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .*-[0-9]{1,10}.*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "-2\x18\u00CC\u00AD\u00EC\u00A9"
(define-fun Witness1 () String (seq.++ "-" (seq.++ "2" (seq.++ "\x18" (seq.++ "\xcc" (seq.++ "\xad" (seq.++ "\xec" (seq.++ "\xa9" ""))))))))
;witness2: "-12\u0082@"
(define-fun Witness2 () String (seq.++ "-" (seq.++ "1" (seq.++ "2" (seq.++ "\x82" (seq.++ "@" ""))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 1 10) (re.range "0" "9")) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
