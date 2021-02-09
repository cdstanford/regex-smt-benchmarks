;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w ]*.*))+\.(jpg|JPG)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\\\u00B5\u00AAK\\u00DC1\u00BA\F.jpg"
(define-fun Witness1 () String (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "\xb5" (seq.++ "\xaa" (seq.++ "K" (seq.++ "\x5c" (seq.++ "\xdc" (seq.++ "1" (seq.++ "\xba" (seq.++ "\x5c" (seq.++ "F" (seq.++ "." (seq.++ "j" (seq.++ "p" (seq.++ "g" ""))))))))))))))))
;witness2: "K:\H\u00AA\u008C\x1F~\x12.JPG"
(define-fun Witness2 () String (seq.++ "K" (seq.++ ":" (seq.++ "\x5c" (seq.++ "H" (seq.++ "\xaa" (seq.++ "\x8c" (seq.++ "\x1f" (seq.++ "~" (seq.++ "\x12" (seq.++ "." (seq.++ "J" (seq.++ "P" (seq.++ "G" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range ":" ":")) (re.++ (re.++ ((_ re.loop 2 2) (re.range "\x5c" "\x5c")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.opt (re.range "$" "$"))))(re.++ (re.+ (re.++ (re.range "\x5c" "\x5c") (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))))))(re.++ (re.range "." ".")(re.++ (re.union (str.to_re (seq.++ "j" (seq.++ "p" (seq.++ "g" "")))) (str.to_re (seq.++ "J" (seq.++ "P" (seq.++ "G" ""))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
