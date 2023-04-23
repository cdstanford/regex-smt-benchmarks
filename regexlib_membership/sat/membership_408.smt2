;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (1)?-?\(?\s*([0-9]{3})\s*\)?\s*-?([0-9]{3})\s*-?\s*([0-9]{4})\s*
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1-\x9\u00A0 \u00A0\u0085992 )\u00A0982-7983)J"
(define-fun Witness1 () String (str.++ "1" (str.++ "-" (str.++ "\u{09}" (str.++ "\u{a0}" (str.++ " " (str.++ "\u{a0}" (str.++ "\u{85}" (str.++ "9" (str.++ "9" (str.++ "2" (str.++ " " (str.++ ")" (str.++ "\u{a0}" (str.++ "9" (str.++ "8" (str.++ "2" (str.++ "-" (str.++ "7" (str.++ "9" (str.++ "8" (str.++ "3" (str.++ ")" (str.++ "J" ""))))))))))))))))))))))))
;witness2: "1-991\u0085)\u00A0-427\xA\xC2897"
(define-fun Witness2 () String (str.++ "1" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "1" (str.++ "\u{85}" (str.++ ")" (str.++ "\u{a0}" (str.++ "-" (str.++ "4" (str.++ "2" (str.++ "7" (str.++ "\u{0a}" (str.++ "\u{0c}" (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "7" "")))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.range "1" "1"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "(" "("))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
