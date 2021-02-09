;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(\d{2}.\d{3}.\d{3}/\d{4}-\d{2})|(\d{14})$)|(^(\d{3}.\d{3}.\d{3}-\d{2})|(\d{11})$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "k51245127919804"
(define-fun Witness1 () String (seq.++ "k" (seq.++ "5" (seq.++ "1" (seq.++ "2" (seq.++ "4" (seq.++ "5" (seq.++ "1" (seq.++ "2" (seq.++ "7" (seq.++ "9" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "4" ""))))))))))))))))
;witness2: "F\u008D\x15\u0087\u00A1\u00B085389440484"
(define-fun Witness2 () String (seq.++ "F" (seq.++ "\x8d" (seq.++ "\x15" (seq.++ "\x87" (seq.++ "\xa1" (seq.++ "\xb0" (seq.++ "8" (seq.++ "5" (seq.++ "3" (seq.++ "8" (seq.++ "9" (seq.++ "4" (seq.++ "4" (seq.++ "0" (seq.++ "4" (seq.++ "8" (seq.++ "4" ""))))))))))))))))))

(assert (= regexA (re.union (re.union (re.++ (str.to_re "") (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "/" "/")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9"))))))))))) (re.++ ((_ re.loop 14 14) (re.range "0" "9")) (str.to_re ""))) (re.union (re.++ (str.to_re "") (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9"))))))))) (re.++ ((_ re.loop 11 11) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
