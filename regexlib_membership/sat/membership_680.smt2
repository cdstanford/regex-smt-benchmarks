;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([1..9])|(0[1..9])|(1\d)|(2\d)|(3[0..1])).((\d)|(0\d)|(1[0..2])).(\d{4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "29t1.C8129"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "9" (seq.++ "t" (seq.++ "1" (seq.++ "." (seq.++ "C" (seq.++ "8" (seq.++ "1" (seq.++ "2" (seq.++ "9" "")))))))))))
;witness2: "09H08\u00DB4888"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "9" (seq.++ "H" (seq.++ "0" (seq.++ "8" (seq.++ "\xdb" (seq.++ "4" (seq.++ "8" (seq.++ "8" (seq.++ "8" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.union (re.range "." ".")(re.union (re.range "1" "1") (re.range "9" "9")))(re.union (re.++ (re.range "0" "0") (re.union (re.range "." ".")(re.union (re.range "1" "1") (re.range "9" "9"))))(re.union (re.++ (re.range "1" "1") (re.range "0" "9"))(re.union (re.++ (re.range "2" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.union (re.range "." ".") (re.range "0" "1")))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1") (re.union (re.range "." ".")(re.union (re.range "0" "0") (re.range "2" "2"))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
