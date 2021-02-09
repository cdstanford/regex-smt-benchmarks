;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((0|128|192|224|240|248|252|254).0.0.0)|(255.(0|128|192|224|240|248|252|254).0.0)|(255.255.(0|128|192|224|240|248|252|254).0)|(255.255.255.(0|128|192|224|240|248|252|254)))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "252W0\u00C40\u00EA0"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "5" (seq.++ "2" (seq.++ "W" (seq.++ "0" (seq.++ "\xc4" (seq.++ "0" (seq.++ "\xea" (seq.++ "0" ""))))))))))
;witness2: "192O0\u00CB0$0"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "9" (seq.++ "2" (seq.++ "O" (seq.++ "0" (seq.++ "\xcb" (seq.++ "0" (seq.++ "$" (seq.++ "0" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "0" "0")(re.union (str.to_re (seq.++ "1" (seq.++ "2" (seq.++ "8" ""))))(re.union (str.to_re (seq.++ "1" (seq.++ "9" (seq.++ "2" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "2" (seq.++ "4" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "4" (seq.++ "0" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "4" (seq.++ "8" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "5" (seq.++ "2" "")))) (str.to_re (seq.++ "2" (seq.++ "5" (seq.++ "4" "")))))))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.range "0" "0")(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.range "0" "0")(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (re.range "0" "0")))))))(re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" (seq.++ "5" ""))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.union (re.range "0" "0")(re.union (str.to_re (seq.++ "1" (seq.++ "2" (seq.++ "8" ""))))(re.union (str.to_re (seq.++ "1" (seq.++ "9" (seq.++ "2" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "2" (seq.++ "4" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "4" (seq.++ "0" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "4" (seq.++ "8" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "5" (seq.++ "2" "")))) (str.to_re (seq.++ "2" (seq.++ "5" (seq.++ "4" "")))))))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.range "0" "0")(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (re.range "0" "0")))))))(re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" (seq.++ "5" ""))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (str.to_re (seq.++ "2" (seq.++ "5" (seq.++ "5" ""))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.union (re.range "0" "0")(re.union (str.to_re (seq.++ "1" (seq.++ "2" (seq.++ "8" ""))))(re.union (str.to_re (seq.++ "1" (seq.++ "9" (seq.++ "2" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "2" (seq.++ "4" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "4" (seq.++ "0" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "4" (seq.++ "8" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "5" (seq.++ "2" "")))) (str.to_re (seq.++ "2" (seq.++ "5" (seq.++ "4" "")))))))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (re.range "0" "0"))))))) (re.++ (str.to_re (seq.++ "2" (seq.++ "5" (seq.++ "5" ""))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (str.to_re (seq.++ "2" (seq.++ "5" (seq.++ "5" ""))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (str.to_re (seq.++ "2" (seq.++ "5" (seq.++ "5" ""))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (re.union (re.range "0" "0")(re.union (str.to_re (seq.++ "1" (seq.++ "2" (seq.++ "8" ""))))(re.union (str.to_re (seq.++ "1" (seq.++ "9" (seq.++ "2" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "2" (seq.++ "4" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "4" (seq.++ "0" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "4" (seq.++ "8" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "5" (seq.++ "2" "")))) (str.to_re (seq.++ "2" (seq.++ "5" (seq.++ "4" "")))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
