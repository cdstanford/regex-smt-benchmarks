;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (AUX|PRN|NUL|COM\d|LPT\d)+\s*$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\xECOM3\u00A0\xD"
(define-fun Witness1 () String (str.++ "\u{0e}" (str.++ "C" (str.++ "O" (str.++ "M" (str.++ "3" (str.++ "\u{a0}" (str.++ "\u{0d}" ""))))))))
;witness2: "PRNLPT1LPT9AUX\u00A0 "
(define-fun Witness2 () String (str.++ "P" (str.++ "R" (str.++ "N" (str.++ "L" (str.++ "P" (str.++ "T" (str.++ "1" (str.++ "L" (str.++ "P" (str.++ "T" (str.++ "9" (str.++ "A" (str.++ "U" (str.++ "X" (str.++ "\u{a0}" (str.++ " " "")))))))))))))))))

(assert (= regexA (re.++ (re.+ (re.union (str.to_re (str.++ "A" (str.++ "U" (str.++ "X" ""))))(re.union (str.to_re (str.++ "P" (str.++ "R" (str.++ "N" ""))))(re.union (str.to_re (str.++ "N" (str.++ "U" (str.++ "L" ""))))(re.union (re.++ (str.to_re (str.++ "C" (str.++ "O" (str.++ "M" "")))) (re.range "0" "9")) (re.++ (str.to_re (str.++ "L" (str.++ "P" (str.++ "T" "")))) (re.range "0" "9")))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
