;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*(?i:)((1[0-2])|(0[1-9])|([123456789])):(([0-5][0-9])|([123456789]))\s(am|pm)\s*$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "08:1\u00A0pm\xB\xD\u00A0"
(define-fun Witness1 () String (str.++ "0" (str.++ "8" (str.++ ":" (str.++ "1" (str.++ "\u{a0}" (str.++ "p" (str.++ "m" (str.++ "\u{0b}" (str.++ "\u{0d}" (str.++ "\u{a0}" "")))))))))))
;witness2: "08:56\xCam\u0085\xD\u00A0"
(define-fun Witness2 () String (str.++ "0" (str.++ "8" (str.++ ":" (str.++ "5" (str.++ "6" (str.++ "\u{0c}" (str.++ "a" (str.++ "m" (str.++ "\u{85}" (str.++ "\u{0d}" (str.++ "\u{a0}" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.++ (re.range "1" "1") (re.range "0" "2"))(re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.range "1" "9")))(re.++ (re.range ":" ":")(re.++ (re.union (re.++ (re.range "0" "5") (re.range "0" "9")) (re.range "1" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.union (str.to_re (str.++ "a" (str.++ "m" ""))) (str.to_re (str.++ "p" (str.++ "m" ""))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
