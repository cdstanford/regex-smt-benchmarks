;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^.+@[^\.].*\.[a-z]{2,}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "C\u00D1\u00D1@<\u00AE.vu"
(define-fun Witness1 () String (seq.++ "C" (seq.++ "\xd1" (seq.++ "\xd1" (seq.++ "@" (seq.++ "<" (seq.++ "\xae" (seq.++ "." (seq.++ "v" (seq.++ "u" ""))))))))))
;witness2: "a/\u00D4\xD@\u00BC\u00E6.szu"
(define-fun Witness2 () String (seq.++ "a" (seq.++ "/" (seq.++ "\xd4" (seq.++ "\x0d" (seq.++ "@" (seq.++ "\xbc" (seq.++ "\xe6" (seq.++ "." (seq.++ "s" (seq.++ "z" (seq.++ "u" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "@" "@")(re.++ (re.union (re.range "\x00" "-") (re.range "/" "\xff"))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "." ".")(re.++ (re.++ ((_ re.loop 2 2) (re.range "a" "z")) (re.* (re.range "a" "z"))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
