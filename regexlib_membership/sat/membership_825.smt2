;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Za-z\-]+)\s+(\w+)\s+([A-Za-z0-9_\-\.]+)\s+([A-Za-z0-9_\-\.]+)\s+(\d+)\s+(.{3} [0-9 ]{2} ([0-9][0-9]:[0-9][0-9]| [0-9]{4}))\s+(.+)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-----Z\xC\u00AAK\u00A09A- 8-\xA\u00854\x9l\u0098\u00AD  8 29:56 \u00A0\u0083"
(define-fun Witness1 () String (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "Z" (str.++ "\u{0c}" (str.++ "\u{aa}" (str.++ "K" (str.++ "\u{a0}" (str.++ "9" (str.++ "A" (str.++ "-" (str.++ " " (str.++ "8" (str.++ "-" (str.++ "\u{0a}" (str.++ "\u{85}" (str.++ "4" (str.++ "\u{09}" (str.++ "l" (str.++ "\u{98}" (str.++ "\u{ad}" (str.++ " " (str.++ " " (str.++ "8" (str.++ " " (str.++ "2" (str.++ "9" (str.++ ":" (str.++ "5" (str.++ "6" (str.++ " " (str.++ "\u{a0}" (str.++ "\u{83}" ""))))))))))))))))))))))))))))))))))))
;witness2: "----x \u0085\xB\u00A0\u0085\u00BA\xA. \u00A0\u00A0\u0085\u0085\xA\u0085z\x9 6 \u00A7(\u0080  8  8981\u0085\u00D8"
(define-fun Witness2 () String (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "x" (str.++ " " (str.++ "\u{85}" (str.++ "\u{0b}" (str.++ "\u{a0}" (str.++ "\u{85}" (str.++ "\u{ba}" (str.++ "\u{0a}" (str.++ "." (str.++ " " (str.++ "\u{a0}" (str.++ "\u{a0}" (str.++ "\u{85}" (str.++ "\u{85}" (str.++ "\u{0a}" (str.++ "\u{85}" (str.++ "z" (str.++ "\u{09}" (str.++ " " (str.++ "6" (str.++ " " (str.++ "\u{a7}" (str.++ "(" (str.++ "\u{80}" (str.++ " " (str.++ " " (str.++ "8" (str.++ " " (str.++ " " (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "1" (str.++ "\u{85}" (str.++ "\u{d8}" ""))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.++ ((_ re.loop 3 3) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range " " " ")(re.++ ((_ re.loop 2 2) (re.union (re.range " " " ") (re.range "0" "9")))(re.++ (re.range " " " ") (re.union (re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range ":" ":")(re.++ (re.range "0" "9") (re.range "0" "9"))))) (re.++ (re.range " " " ") ((_ re.loop 4 4) (re.range "0" "9"))))))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re "")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
