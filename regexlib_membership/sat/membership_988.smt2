;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:(?'1'[0-9a-fA-F]{2})(?:\:)(?'2'[0-9a-fA-F]{2})(?:\:)(?'3'[0-9a-fA-F]{2})(?:\:)(?'4'[0-9a-fA-F]{2})(?:\:)(?'5'[0-9a-fA-F]{2})(?:\:)(?'6'[0-9a-fA-F]{2}))$|^(?:(?'1'[0-9a-fA-F]{2})(?:\-)(?'2'[0-9a-fA-F]{2})(?:\-)(?'3'[0-9a-fA-F]{2})(?:\-)(?'4'[0-9a-fA-F]{2})(?:\-)(?'5'[0-9a-fA-F]{2})(?:\-)(?'6'[0-9a-fA-F]{2}))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "A8-29-C8-6D-f8-90"
(define-fun Witness1 () String (seq.++ "A" (seq.++ "8" (seq.++ "-" (seq.++ "2" (seq.++ "9" (seq.++ "-" (seq.++ "C" (seq.++ "8" (seq.++ "-" (seq.++ "6" (seq.++ "D" (seq.++ "-" (seq.++ "f" (seq.++ "8" (seq.++ "-" (seq.++ "9" (seq.++ "0" ""))))))))))))))))))
;witness2: "eD-9C-9a-96-Fe-9D"
(define-fun Witness2 () String (seq.++ "e" (seq.++ "D" (seq.++ "-" (seq.++ "9" (seq.++ "C" (seq.++ "-" (seq.++ "9" (seq.++ "a" (seq.++ "-" (seq.++ "9" (seq.++ "6" (seq.++ "-" (seq.++ "F" (seq.++ "e" (seq.++ "-" (seq.++ "9" (seq.++ "D" ""))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (str.to_re ""))))))))))))) (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (str.to_re ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
