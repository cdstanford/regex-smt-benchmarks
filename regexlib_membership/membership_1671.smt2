;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{2}\s{1}(Jan|Feb|Mar|Apr|May|Jun|Jul|Apr|Sep|Oct|Nov|Dec)\s{1}\d{4}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "47\u0085Mar\x99210"
(define-fun Witness1 () String (str.++ "4" (str.++ "7" (str.++ "\u{85}" (str.++ "M" (str.++ "a" (str.++ "r" (str.++ "\u{09}" (str.++ "9" (str.++ "2" (str.++ "1" (str.++ "0" ""))))))))))))
;witness2: "58\u0085Nov 2908"
(define-fun Witness2 () String (str.++ "5" (str.++ "8" (str.++ "\u{85}" (str.++ "N" (str.++ "o" (str.++ "v" (str.++ " " (str.++ "2" (str.++ "9" (str.++ "0" (str.++ "8" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.union (str.to_re (str.++ "J" (str.++ "a" (str.++ "n" ""))))(re.union (str.to_re (str.++ "F" (str.++ "e" (str.++ "b" ""))))(re.union (str.to_re (str.++ "M" (str.++ "a" (str.++ "r" ""))))(re.union (str.to_re (str.++ "A" (str.++ "p" (str.++ "r" ""))))(re.union (str.to_re (str.++ "M" (str.++ "a" (str.++ "y" ""))))(re.union (str.to_re (str.++ "J" (str.++ "u" (str.++ "n" ""))))(re.union (str.to_re (str.++ "J" (str.++ "u" (str.++ "l" ""))))(re.union (str.to_re (str.++ "A" (str.++ "p" (str.++ "r" ""))))(re.union (str.to_re (str.++ "S" (str.++ "e" (str.++ "p" ""))))(re.union (str.to_re (str.++ "O" (str.++ "c" (str.++ "t" ""))))(re.union (str.to_re (str.++ "N" (str.++ "o" (str.++ "v" "")))) (str.to_re (str.++ "D" (str.++ "e" (str.++ "c" "")))))))))))))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
