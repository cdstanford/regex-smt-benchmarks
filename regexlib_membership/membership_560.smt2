;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]:\\(([\w]|[\u0621-\u064A\s])+\\)+([\w]|[\u0621-\u064A\s])+(.jpg|.JPG|.gif|.GIF|.BNG|.bng)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "A:\_\\u0085\DzGIF"
(define-fun Witness1 () String (str.++ "A" (str.++ ":" (str.++ "\u{5c}" (str.++ "_" (str.++ "\u{5c}" (str.++ "\u{85}" (str.++ "\u{5c}" (str.++ "D" (str.++ "z" (str.++ "G" (str.++ "I" (str.++ "F" "")))))))))))))
;witness2: "w:\\u00FE\ \ \\u00EDl \Z\u00BAP\u0085\u0085\u00C3\sr \\u0085\u00A6JPG"
(define-fun Witness2 () String (str.++ "w" (str.++ ":" (str.++ "\u{5c}" (str.++ "\u{fe}" (str.++ "\u{5c}" (str.++ " " (str.++ "\u{5c}" (str.++ " " (str.++ "\u{5c}" (str.++ "\u{ed}" (str.++ "l" (str.++ " " (str.++ "\u{5c}" (str.++ "Z" (str.++ "\u{ba}" (str.++ "P" (str.++ "\u{85}" (str.++ "\u{85}" (str.++ "\u{c3}" (str.++ "\u{5c}" (str.++ "s" (str.++ "r" (str.++ " " (str.++ "\u{5c}" (str.++ "\u{85}" (str.++ "\u{a6}" (str.++ "J" (str.++ "P" (str.++ "G" ""))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (str.to_re (str.++ ":" (str.++ "\u{5c}" "")))(re.++ (re.+ (re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}")(re.union (re.range "\u{a0}" "\u{a0}")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))) (re.range "\u{5c}" "\u{5c}")))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}")(re.union (re.range "\u{a0}" "\u{a0}")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))(re.++ (re.union (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "j" (str.++ "p" (str.++ "g" "")))))(re.union (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "J" (str.++ "P" (str.++ "G" "")))))(re.union (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "g" (str.++ "i" (str.++ "f" "")))))(re.union (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "G" (str.++ "I" (str.++ "F" "")))))(re.union (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "B" (str.++ "N" (str.++ "G" ""))))) (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "b" (str.++ "n" (str.++ "g" "")))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
