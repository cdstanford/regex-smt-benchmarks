;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9a-fA-F][0-9a-fA-F]:){5}([0-9a-fA-F][0-9a-fA-F])$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "F9:88:D9:1f:aB:5d"
(define-fun Witness1 () String (seq.++ "F" (seq.++ "9" (seq.++ ":" (seq.++ "8" (seq.++ "8" (seq.++ ":" (seq.++ "D" (seq.++ "9" (seq.++ ":" (seq.++ "1" (seq.++ "f" (seq.++ ":" (seq.++ "a" (seq.++ "B" (seq.++ ":" (seq.++ "5" (seq.++ "d" ""))))))))))))))))))
;witness2: "71:aa:eA:db:D2:2B"
(define-fun Witness2 () String (seq.++ "7" (seq.++ "1" (seq.++ ":" (seq.++ "a" (seq.++ "a" (seq.++ ":" (seq.++ "e" (seq.++ "A" (seq.++ ":" (seq.++ "d" (seq.++ "b" (seq.++ ":" (seq.++ "D" (seq.++ "2" (seq.++ ":" (seq.++ "2" (seq.++ "B" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))) (re.range ":" ":"))))(re.++ (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
