;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = http://www.carreg.co.uk/number_plates/registration_numbers
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "http://www\u00F9carreg\u00A7coOuk/number_plates/registration_numbers\u0087\u00C1"
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "\u{f9}" (str.++ "c" (str.++ "a" (str.++ "r" (str.++ "r" (str.++ "e" (str.++ "g" (str.++ "\u{a7}" (str.++ "c" (str.++ "o" (str.++ "O" (str.++ "u" (str.++ "k" (str.++ "/" (str.++ "n" (str.++ "u" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" (str.++ "_" (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "t" (str.++ "e" (str.++ "s" (str.++ "/" (str.++ "r" (str.++ "e" (str.++ "g" (str.++ "i" (str.++ "s" (str.++ "t" (str.++ "r" (str.++ "a" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "_" (str.++ "n" (str.++ "u" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" (str.++ "s" (str.++ "\u{87}" (str.++ "\u{c1}" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "\u00EC\u00D5http://www;carreg\u0092co-uk/number_plates/registration_numbers\u00D9"
(define-fun Witness2 () String (str.++ "\u{ec}" (str.++ "\u{d5}" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ ";" (str.++ "c" (str.++ "a" (str.++ "r" (str.++ "r" (str.++ "e" (str.++ "g" (str.++ "\u{92}" (str.++ "c" (str.++ "o" (str.++ "-" (str.++ "u" (str.++ "k" (str.++ "/" (str.++ "n" (str.++ "u" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" (str.++ "_" (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "t" (str.++ "e" (str.++ "s" (str.++ "/" (str.++ "r" (str.++ "e" (str.++ "g" (str.++ "i" (str.++ "s" (str.++ "t" (str.++ "r" (str.++ "a" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "_" (str.++ "n" (str.++ "u" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" (str.++ "s" (str.++ "\u{d9}" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" "")))))))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (str.to_re (str.++ "c" (str.++ "a" (str.++ "r" (str.++ "r" (str.++ "e" (str.++ "g" "")))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (str.to_re (str.++ "c" (str.++ "o" "")))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "u" (str.++ "k" (str.++ "/" (str.++ "n" (str.++ "u" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" (str.++ "_" (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "t" (str.++ "e" (str.++ "s" (str.++ "/" (str.++ "r" (str.++ "e" (str.++ "g" (str.++ "i" (str.++ "s" (str.++ "t" (str.++ "r" (str.++ "a" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "_" (str.++ "n" (str.++ "u" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" (str.++ "s" ""))))))))))))))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
