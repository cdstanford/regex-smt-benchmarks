;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\"http:\/\/www\.youtube\.com\/v\/\w{11}\&rel\=1\")
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\"http://www.youtube.com/v/E\u00AA\u00AA\u00D50I\u00F3F9C\u00AA&rel=1\"\x2"
(define-fun Witness1 () String (seq.++ "\x22" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "y" (seq.++ "o" (seq.++ "u" (seq.++ "t" (seq.++ "u" (seq.++ "b" (seq.++ "e" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "v" (seq.++ "/" (seq.++ "E" (seq.++ "\xaa" (seq.++ "\xaa" (seq.++ "\xd5" (seq.++ "0" (seq.++ "I" (seq.++ "\xf3" (seq.++ "F" (seq.++ "9" (seq.++ "C" (seq.++ "\xaa" (seq.++ "&" (seq.++ "r" (seq.++ "e" (seq.++ "l" (seq.++ "=" (seq.++ "1" (seq.++ "\x22" (seq.++ "\x02" ""))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "\u00F4~\"http://www.youtube.com/v/_V\u00B5E\u00C4\u00BAi3o3\u00AA&rel=1\"/\u00ED\u00D8"
(define-fun Witness2 () String (seq.++ "\xf4" (seq.++ "~" (seq.++ "\x22" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "y" (seq.++ "o" (seq.++ "u" (seq.++ "t" (seq.++ "u" (seq.++ "b" (seq.++ "e" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "v" (seq.++ "/" (seq.++ "_" (seq.++ "V" (seq.++ "\xb5" (seq.++ "E" (seq.++ "\xc4" (seq.++ "\xba" (seq.++ "i" (seq.++ "3" (seq.++ "o" (seq.++ "3" (seq.++ "\xaa" (seq.++ "&" (seq.++ "r" (seq.++ "e" (seq.++ "l" (seq.++ "=" (seq.++ "1" (seq.++ "\x22" (seq.++ "/" (seq.++ "\xed" (seq.++ "\xd8" ""))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "\x22" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "y" (seq.++ "o" (seq.++ "u" (seq.++ "t" (seq.++ "u" (seq.++ "b" (seq.++ "e" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "v" (seq.++ "/" "")))))))))))))))))))))))))))(re.++ ((_ re.loop 11 11) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (str.to_re (seq.++ "&" (seq.++ "r" (seq.++ "e" (seq.++ "l" (seq.++ "=" (seq.++ "1" (seq.++ "\x22" ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
