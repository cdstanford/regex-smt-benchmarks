;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]:\\(([\w]|[\u0621-\u064A\s])+\\)+([\w]|[\u0621-\u064A\s])+(.jpg|.JPG|.gif|.GIF|.BNG|.bng)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "A:\_\\u0085\DzGIF"
(define-fun Witness1 () String (seq.++ "A" (seq.++ ":" (seq.++ "\x5c" (seq.++ "_" (seq.++ "\x5c" (seq.++ "\x85" (seq.++ "\x5c" (seq.++ "D" (seq.++ "z" (seq.++ "G" (seq.++ "I" (seq.++ "F" "")))))))))))))
;witness2: "w:\\u00FE\ \ \\u00EDl \Z\u00BAP\u0085\u0085\u00C3\sr \\u0085\u00A6JPG"
(define-fun Witness2 () String (seq.++ "w" (seq.++ ":" (seq.++ "\x5c" (seq.++ "\xfe" (seq.++ "\x5c" (seq.++ " " (seq.++ "\x5c" (seq.++ " " (seq.++ "\x5c" (seq.++ "\xed" (seq.++ "l" (seq.++ " " (seq.++ "\x5c" (seq.++ "Z" (seq.++ "\xba" (seq.++ "P" (seq.++ "\x85" (seq.++ "\x85" (seq.++ "\xc3" (seq.++ "\x5c" (seq.++ "s" (seq.++ "r" (seq.++ " " (seq.++ "\x5c" (seq.++ "\x85" (seq.++ "\xa6" (seq.++ "J" (seq.++ "P" (seq.++ "G" ""))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (str.to_re (seq.++ ":" (seq.++ "\x5c" "")))(re.++ (re.+ (re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85")(re.union (re.range "\xa0" "\xa0")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))) (re.range "\x5c" "\x5c")))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85")(re.union (re.range "\xa0" "\xa0")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))(re.++ (re.union (re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "j" (seq.++ "p" (seq.++ "g" "")))))(re.union (re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "J" (seq.++ "P" (seq.++ "G" "")))))(re.union (re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "g" (seq.++ "i" (seq.++ "f" "")))))(re.union (re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "G" (seq.++ "I" (seq.++ "F" "")))))(re.union (re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "B" (seq.++ "N" (seq.++ "G" ""))))) (re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "b" (seq.++ "n" (seq.++ "g" "")))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
