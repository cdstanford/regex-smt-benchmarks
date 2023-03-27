;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9a-fA-F][0-9a-fA-F]:){5}([0-9a-fA-F][0-9a-fA-F])$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "F9:88:D9:1f:aB:5d"
(define-fun Witness1 () String (str.++ "F" (str.++ "9" (str.++ ":" (str.++ "8" (str.++ "8" (str.++ ":" (str.++ "D" (str.++ "9" (str.++ ":" (str.++ "1" (str.++ "f" (str.++ ":" (str.++ "a" (str.++ "B" (str.++ ":" (str.++ "5" (str.++ "d" ""))))))))))))))))))
;witness2: "71:aa:eA:db:D2:2B"
(define-fun Witness2 () String (str.++ "7" (str.++ "1" (str.++ ":" (str.++ "a" (str.++ "a" (str.++ ":" (str.++ "e" (str.++ "A" (str.++ ":" (str.++ "d" (str.++ "b" (str.++ ":" (str.++ "D" (str.++ "2" (str.++ ":" (str.++ "2" (str.++ "B" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))) (re.range ":" ":"))))(re.++ (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
