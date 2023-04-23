;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\"http:\/\/www\.youtube\.com\/v\/\w{11}\&rel\=1\")
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\"http://www.youtube.com/v/E\u00AA\u00AA\u00D50I\u00F3F9C\u00AA&rel=1\"\x2"
(define-fun Witness1 () String (str.++ "\u{22}" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." (str.++ "y" (str.++ "o" (str.++ "u" (str.++ "t" (str.++ "u" (str.++ "b" (str.++ "e" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "v" (str.++ "/" (str.++ "E" (str.++ "\u{aa}" (str.++ "\u{aa}" (str.++ "\u{d5}" (str.++ "0" (str.++ "I" (str.++ "\u{f3}" (str.++ "F" (str.++ "9" (str.++ "C" (str.++ "\u{aa}" (str.++ "&" (str.++ "r" (str.++ "e" (str.++ "l" (str.++ "=" (str.++ "1" (str.++ "\u{22}" (str.++ "\u{02}" ""))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "\u00F4~\"http://www.youtube.com/v/_V\u00B5E\u00C4\u00BAi3o3\u00AA&rel=1\"/\u00ED\u00D8"
(define-fun Witness2 () String (str.++ "\u{f4}" (str.++ "~" (str.++ "\u{22}" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." (str.++ "y" (str.++ "o" (str.++ "u" (str.++ "t" (str.++ "u" (str.++ "b" (str.++ "e" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "v" (str.++ "/" (str.++ "_" (str.++ "V" (str.++ "\u{b5}" (str.++ "E" (str.++ "\u{c4}" (str.++ "\u{ba}" (str.++ "i" (str.++ "3" (str.++ "o" (str.++ "3" (str.++ "\u{aa}" (str.++ "&" (str.++ "r" (str.++ "e" (str.++ "l" (str.++ "=" (str.++ "1" (str.++ "\u{22}" (str.++ "/" (str.++ "\u{ed}" (str.++ "\u{d8}" ""))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "\u{22}" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." (str.++ "y" (str.++ "o" (str.++ "u" (str.++ "t" (str.++ "u" (str.++ "b" (str.++ "e" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "v" (str.++ "/" "")))))))))))))))))))))))))))(re.++ ((_ re.loop 11 11) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (str.to_re (str.++ "&" (str.++ "r" (str.++ "e" (str.++ "l" (str.++ "=" (str.++ "1" (str.++ "\u{22}" ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
