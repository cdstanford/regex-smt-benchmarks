;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\d{0}[0-9]|\d{0}[1]\d{0}[0-2])(\:)\d{0}[0-5]\d{0}[0-9](\:)\d{0}[0-5]\d{0}[0-9]\s(AM|PM))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "12:48:15\u00A0PM"
(define-fun Witness1 () String (str.++ "1" (str.++ "2" (str.++ ":" (str.++ "4" (str.++ "8" (str.++ ":" (str.++ "1" (str.++ "5" (str.++ "\u{a0}" (str.++ "P" (str.++ "M" ""))))))))))))
;witness2: "4:49:42\x9PMXR"
(define-fun Witness2 () String (str.++ "4" (str.++ ":" (str.++ "4" (str.++ "9" (str.++ ":" (str.++ "4" (str.++ "2" (str.++ "\u{09}" (str.++ "P" (str.++ "M" (str.++ "X" (str.++ "R" "")))))))))))))

(assert (= regexA (re.++ (re.union (re.range "0" "9") (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) (re.union (str.to_re (str.++ "A" (str.++ "M" ""))) (str.to_re (str.++ "P" (str.++ "M" ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
