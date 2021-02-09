;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<user>.+)@(?<domain>.+)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00F2@@"
(define-fun Witness1 () String (seq.++ "\xf2" (seq.++ "@" (seq.++ "@" ""))))
;witness2: "Q@\u00E8"
(define-fun Witness2 () String (seq.++ "Q" (seq.++ "@" (seq.++ "\xe8" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
