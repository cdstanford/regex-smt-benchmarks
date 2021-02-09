;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^.+\@.+\..+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00BC\u0091@\u00F1.\u009E"
(define-fun Witness1 () String (seq.++ "\xbc" (seq.++ "\x91" (seq.++ "@" (seq.++ "\xf1" (seq.++ "." (seq.++ "\x9e" "")))))))
;witness2: "\u00CC@\x1.\u00F69"
(define-fun Witness2 () String (seq.++ "\xcc" (seq.++ "@" (seq.++ "\x01" (seq.++ "." (seq.++ "\xf6" (seq.++ "9" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
