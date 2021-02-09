;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = "\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}"
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0097q\"\ddd\\u00CC\d\H\d\\u0097\ddd\"A\u00B6"
(define-fun Witness1 () String (seq.++ "\x97" (seq.++ "q" (seq.++ "\x22" (seq.++ "\x5c" (seq.++ "d" (seq.++ "d" (seq.++ "d" (seq.++ "\x5c" (seq.++ "\xcc" (seq.++ "\x5c" (seq.++ "d" (seq.++ "\x5c" (seq.++ "H" (seq.++ "\x5c" (seq.++ "d" (seq.++ "\x5c" (seq.++ "\x97" (seq.++ "\x5c" (seq.++ "d" (seq.++ "d" (seq.++ "d" (seq.++ "\x22" (seq.++ "A" (seq.++ "\xb6" "")))))))))))))))))))))))))
;witness2: "\u00CD\u00EE\"\ddd\\u009E\ddd\\u0093\d\\x1A\dd\""
(define-fun Witness2 () String (seq.++ "\xcd" (seq.++ "\xee" (seq.++ "\x22" (seq.++ "\x5c" (seq.++ "d" (seq.++ "d" (seq.++ "d" (seq.++ "\x5c" (seq.++ "\x9e" (seq.++ "\x5c" (seq.++ "d" (seq.++ "d" (seq.++ "d" (seq.++ "\x5c" (seq.++ "\x93" (seq.++ "\x5c" (seq.++ "d" (seq.++ "\x5c" (seq.++ "\x1a" (seq.++ "\x5c" (seq.++ "d" (seq.++ "d" (seq.++ "\x22" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "\x22" (seq.++ "\x5c" "")))(re.++ ((_ re.loop 1 3) (re.range "d" "d"))(re.++ (re.range "\x5c" "\x5c")(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.range "\x5c" "\x5c")(re.++ ((_ re.loop 1 3) (re.range "d" "d"))(re.++ (re.range "\x5c" "\x5c")(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.range "\x5c" "\x5c")(re.++ ((_ re.loop 1 3) (re.range "d" "d"))(re.++ (re.range "\x5c" "\x5c")(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.range "\x5c" "\x5c")(re.++ ((_ re.loop 1 3) (re.range "d" "d")) (re.range "\x22" "\x22")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
