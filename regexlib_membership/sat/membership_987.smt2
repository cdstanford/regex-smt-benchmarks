;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:(?'1'[0-9a-fA-F]{2})(?:\:)(?'2'[0-9a-fA-F]{2})(?:\:)(?'3'[0-9a-fA-F]{2})(?:\:)(?'4'[0-9a-fA-F]{2})(?:\:)(?'5'[0-9a-fA-F]{2})(?:\:)(?'6'[0-9a-fA-F]{2}))|(?:(?'1'[0-9a-fA-F]{2})(?:\-)(?'2'[0-9a-fA-F]{2})(?:\-)(?'3'[0-9a-fA-F]{2})(?:\-)(?'4'[0-9a-fA-F]{2})(?:\-)(?'5'[0-9a-fA-F]{2})(?:\-)(?'6'[0-9a-fA-F]{2}))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: " \u0083B8:18:fe:F9:89:89\xB"
(define-fun Witness1 () String (str.++ " " (str.++ "\u{83}" (str.++ "B" (str.++ "8" (str.++ ":" (str.++ "1" (str.++ "8" (str.++ ":" (str.++ "f" (str.++ "e" (str.++ ":" (str.++ "F" (str.++ "9" (str.++ ":" (str.++ "8" (str.++ "9" (str.++ ":" (str.++ "8" (str.++ "9" (str.++ "\u{0b}" "")))))))))))))))))))))
;witness2: "F9-d6-F1-fe-C3-E1kq\u00E2"
(define-fun Witness2 () String (str.++ "F" (str.++ "9" (str.++ "-" (str.++ "d" (str.++ "6" (str.++ "-" (str.++ "F" (str.++ "1" (str.++ "-" (str.++ "f" (str.++ "e" (str.++ "-" (str.++ "C" (str.++ "3" (str.++ "-" (str.++ "E" (str.++ "1" (str.++ "k" (str.++ "q" (str.++ "\u{e2}" "")))))))))))))))))))))

(assert (= regexA (re.union (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range ":" ":") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))))))))) (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
