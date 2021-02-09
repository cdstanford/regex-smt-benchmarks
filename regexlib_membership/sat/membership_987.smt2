;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:(?'1'[0-9a-fA-F]{2})(?:\:)(?'2'[0-9a-fA-F]{2})(?:\:)(?'3'[0-9a-fA-F]{2})(?:\:)(?'4'[0-9a-fA-F]{2})(?:\:)(?'5'[0-9a-fA-F]{2})(?:\:)(?'6'[0-9a-fA-F]{2}))|(?:(?'1'[0-9a-fA-F]{2})(?:\-)(?'2'[0-9a-fA-F]{2})(?:\-)(?'3'[0-9a-fA-F]{2})(?:\-)(?'4'[0-9a-fA-F]{2})(?:\-)(?'5'[0-9a-fA-F]{2})(?:\-)(?'6'[0-9a-fA-F]{2}))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: " \u0083B8:18:fe:F9:89:89\xB"
(define-fun Witness1 () String (seq.++ " " (seq.++ "\x83" (seq.++ "B" (seq.++ "8" (seq.++ ":" (seq.++ "1" (seq.++ "8" (seq.++ ":" (seq.++ "f" (seq.++ "e" (seq.++ ":" (seq.++ "F" (seq.++ "9" (seq.++ ":" (seq.++ "8" (seq.++ "9" (seq.++ ":" (seq.++ "8" (seq.++ "9" (seq.++ "\x0b" "")))))))))))))))))))))
;witness2: "F9-d6-F1-fe-C3-E1kq\u00E2"
(define-fun Witness2 () String (seq.++ "F" (seq.++ "9" (seq.++ "-" (seq.++ "d" (seq.++ "6" (seq.++ "-" (seq.++ "F" (seq.++ "1" (seq.++ "-" (seq.++ "f" (seq.++ "e" (seq.++ "-" (seq.++ "C" (seq.++ "3" (seq.++ "-" (seq.++ "E" (seq.++ "1" (seq.++ "k" (seq.++ "q" (seq.++ "\xe2" "")))))))))))))))))))))

(assert (= regexA (re.union (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range ":" ":") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))))))))) (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
