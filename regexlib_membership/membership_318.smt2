;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \+44\s\(0\)\s\d{2}\s\d{4}\s\d{4}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+44\xD(0)\u00A086 9648\u00859632\u00E4"
(define-fun Witness1 () String (str.++ "+" (str.++ "4" (str.++ "4" (str.++ "\u{0d}" (str.++ "(" (str.++ "0" (str.++ ")" (str.++ "\u{a0}" (str.++ "8" (str.++ "6" (str.++ " " (str.++ "9" (str.++ "6" (str.++ "4" (str.++ "8" (str.++ "\u{85}" (str.++ "9" (str.++ "6" (str.++ "3" (str.++ "2" (str.++ "\u{e4}" ""))))))))))))))))))))))
;witness2: "+44 (0)\u008529 9519\u00858899\u0098"
(define-fun Witness2 () String (str.++ "+" (str.++ "4" (str.++ "4" (str.++ " " (str.++ "(" (str.++ "0" (str.++ ")" (str.++ "\u{85}" (str.++ "2" (str.++ "9" (str.++ " " (str.++ "9" (str.++ "5" (str.++ "1" (str.++ "9" (str.++ "\u{85}" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "\u{98}" ""))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "+" (str.++ "4" (str.++ "4" ""))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (str.to_re (str.++ "(" (str.++ "0" (str.++ ")" ""))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) ((_ re.loop 4 4) (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
