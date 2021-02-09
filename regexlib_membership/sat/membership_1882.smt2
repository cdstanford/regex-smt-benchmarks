;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^.{4,8}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "*\u0092>\u0083\u00CD\x3U\x12"
(define-fun Witness1 () String (seq.++ "*" (seq.++ "\x92" (seq.++ ">" (seq.++ "\x83" (seq.++ "\xcd" (seq.++ "\x03" (seq.++ "U" (seq.++ "\x12" "")))))))))
;witness2: "h\u00D2\u00D4\u00872"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "\xd2" (seq.++ "\xd4" (seq.++ "\x87" (seq.++ "2" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 8) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
