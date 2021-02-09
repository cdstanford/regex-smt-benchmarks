;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = http://www.carreg.co.uk/number_plates/registration_numbers
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "http://www\u00F9carreg\u00A7coOuk/number_plates/registration_numbers\u0087\u00C1"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "\xf9" (seq.++ "c" (seq.++ "a" (seq.++ "r" (seq.++ "r" (seq.++ "e" (seq.++ "g" (seq.++ "\xa7" (seq.++ "c" (seq.++ "o" (seq.++ "O" (seq.++ "u" (seq.++ "k" (seq.++ "/" (seq.++ "n" (seq.++ "u" (seq.++ "m" (seq.++ "b" (seq.++ "e" (seq.++ "r" (seq.++ "_" (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "t" (seq.++ "e" (seq.++ "s" (seq.++ "/" (seq.++ "r" (seq.++ "e" (seq.++ "g" (seq.++ "i" (seq.++ "s" (seq.++ "t" (seq.++ "r" (seq.++ "a" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ "_" (seq.++ "n" (seq.++ "u" (seq.++ "m" (seq.++ "b" (seq.++ "e" (seq.++ "r" (seq.++ "s" (seq.++ "\x87" (seq.++ "\xc1" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "\u00EC\u00D5http://www;carreg\u0092co-uk/number_plates/registration_numbers\u00D9"
(define-fun Witness2 () String (seq.++ "\xec" (seq.++ "\xd5" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ ";" (seq.++ "c" (seq.++ "a" (seq.++ "r" (seq.++ "r" (seq.++ "e" (seq.++ "g" (seq.++ "\x92" (seq.++ "c" (seq.++ "o" (seq.++ "-" (seq.++ "u" (seq.++ "k" (seq.++ "/" (seq.++ "n" (seq.++ "u" (seq.++ "m" (seq.++ "b" (seq.++ "e" (seq.++ "r" (seq.++ "_" (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "t" (seq.++ "e" (seq.++ "s" (seq.++ "/" (seq.++ "r" (seq.++ "e" (seq.++ "g" (seq.++ "i" (seq.++ "s" (seq.++ "t" (seq.++ "r" (seq.++ "a" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ "_" (seq.++ "n" (seq.++ "u" (seq.++ "m" (seq.++ "b" (seq.++ "e" (seq.++ "r" (seq.++ "s" (seq.++ "\xd9" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" "")))))))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (str.to_re (seq.++ "c" (seq.++ "a" (seq.++ "r" (seq.++ "r" (seq.++ "e" (seq.++ "g" "")))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (str.to_re (seq.++ "c" (seq.++ "o" "")))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "u" (seq.++ "k" (seq.++ "/" (seq.++ "n" (seq.++ "u" (seq.++ "m" (seq.++ "b" (seq.++ "e" (seq.++ "r" (seq.++ "_" (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "t" (seq.++ "e" (seq.++ "s" (seq.++ "/" (seq.++ "r" (seq.++ "e" (seq.++ "g" (seq.++ "i" (seq.++ "s" (seq.++ "t" (seq.++ "r" (seq.++ "a" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ "_" (seq.++ "n" (seq.++ "u" (seq.++ "m" (seq.++ "b" (seq.++ "e" (seq.++ "r" (seq.++ "s" ""))))))))))))))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
