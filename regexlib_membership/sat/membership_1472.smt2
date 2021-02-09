;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =    ([A-Za-z\d.]{2,31}) #accept ASCII alphanumeric and period
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "   d. #accept ASCII alphanumeric and periody"
(define-fun Witness1 () String (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "d" (seq.++ "." (seq.++ " " (seq.++ "#" (seq.++ "a" (seq.++ "c" (seq.++ "c" (seq.++ "e" (seq.++ "p" (seq.++ "t" (seq.++ " " (seq.++ "A" (seq.++ "S" (seq.++ "C" (seq.++ "I" (seq.++ "I" (seq.++ " " (seq.++ "a" (seq.++ "l" (seq.++ "p" (seq.++ "h" (seq.++ "a" (seq.++ "n" (seq.++ "u" (seq.++ "m" (seq.++ "e" (seq.++ "r" (seq.++ "i" (seq.++ "c" (seq.++ " " (seq.++ "a" (seq.++ "n" (seq.++ "d" (seq.++ " " (seq.++ "p" (seq.++ "e" (seq.++ "r" (seq.++ "i" (seq.++ "o" (seq.++ "d" (seq.++ "y" "")))))))))))))))))))))))))))))))))))))))))))))
;witness2: "   .t #accept ASCII alphanumeric and period\u00EE\x1B"
(define-fun Witness2 () String (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "." (seq.++ "t" (seq.++ " " (seq.++ "#" (seq.++ "a" (seq.++ "c" (seq.++ "c" (seq.++ "e" (seq.++ "p" (seq.++ "t" (seq.++ " " (seq.++ "A" (seq.++ "S" (seq.++ "C" (seq.++ "I" (seq.++ "I" (seq.++ " " (seq.++ "a" (seq.++ "l" (seq.++ "p" (seq.++ "h" (seq.++ "a" (seq.++ "n" (seq.++ "u" (seq.++ "m" (seq.++ "e" (seq.++ "r" (seq.++ "i" (seq.++ "c" (seq.++ " " (seq.++ "a" (seq.++ "n" (seq.++ "d" (seq.++ " " (seq.++ "p" (seq.++ "e" (seq.++ "r" (seq.++ "i" (seq.++ "o" (seq.++ "d" (seq.++ "\xee" (seq.++ "\x1b" ""))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ " " (seq.++ " " (seq.++ " " ""))))(re.++ ((_ re.loop 2 31) (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (str.to_re (seq.++ " " (seq.++ "#" (seq.++ "a" (seq.++ "c" (seq.++ "c" (seq.++ "e" (seq.++ "p" (seq.++ "t" (seq.++ " " (seq.++ "A" (seq.++ "S" (seq.++ "C" (seq.++ "I" (seq.++ "I" (seq.++ " " (seq.++ "a" (seq.++ "l" (seq.++ "p" (seq.++ "h" (seq.++ "a" (seq.++ "n" (seq.++ "u" (seq.++ "m" (seq.++ "e" (seq.++ "r" (seq.++ "i" (seq.++ "c" (seq.++ " " (seq.++ "a" (seq.++ "n" (seq.++ "d" (seq.++ " " (seq.++ "p" (seq.++ "e" (seq.++ "r" (seq.++ "i" (seq.++ "o" (seq.++ "d" "")))))))))))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
