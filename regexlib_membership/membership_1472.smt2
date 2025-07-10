;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =    ([A-Za-z\d.]{2,31}) #accept ASCII alphanumeric and period
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "   d. #accept ASCII alphanumeric and periody"
(define-fun Witness1 () String (str.++ " " (str.++ " " (str.++ " " (str.++ "d" (str.++ "." (str.++ " " (str.++ "#" (str.++ "a" (str.++ "c" (str.++ "c" (str.++ "e" (str.++ "p" (str.++ "t" (str.++ " " (str.++ "A" (str.++ "S" (str.++ "C" (str.++ "I" (str.++ "I" (str.++ " " (str.++ "a" (str.++ "l" (str.++ "p" (str.++ "h" (str.++ "a" (str.++ "n" (str.++ "u" (str.++ "m" (str.++ "e" (str.++ "r" (str.++ "i" (str.++ "c" (str.++ " " (str.++ "a" (str.++ "n" (str.++ "d" (str.++ " " (str.++ "p" (str.++ "e" (str.++ "r" (str.++ "i" (str.++ "o" (str.++ "d" (str.++ "y" "")))))))))))))))))))))))))))))))))))))))))))))
;witness2: "   .t #accept ASCII alphanumeric and period\u00EE\x1B"
(define-fun Witness2 () String (str.++ " " (str.++ " " (str.++ " " (str.++ "." (str.++ "t" (str.++ " " (str.++ "#" (str.++ "a" (str.++ "c" (str.++ "c" (str.++ "e" (str.++ "p" (str.++ "t" (str.++ " " (str.++ "A" (str.++ "S" (str.++ "C" (str.++ "I" (str.++ "I" (str.++ " " (str.++ "a" (str.++ "l" (str.++ "p" (str.++ "h" (str.++ "a" (str.++ "n" (str.++ "u" (str.++ "m" (str.++ "e" (str.++ "r" (str.++ "i" (str.++ "c" (str.++ " " (str.++ "a" (str.++ "n" (str.++ "d" (str.++ " " (str.++ "p" (str.++ "e" (str.++ "r" (str.++ "i" (str.++ "o" (str.++ "d" (str.++ "\u{ee}" (str.++ "\u{1b}" ""))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ " " (str.++ " " (str.++ " " ""))))(re.++ ((_ re.loop 2 31) (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (str.to_re (str.++ " " (str.++ "#" (str.++ "a" (str.++ "c" (str.++ "c" (str.++ "e" (str.++ "p" (str.++ "t" (str.++ " " (str.++ "A" (str.++ "S" (str.++ "C" (str.++ "I" (str.++ "I" (str.++ " " (str.++ "a" (str.++ "l" (str.++ "p" (str.++ "h" (str.++ "a" (str.++ "n" (str.++ "u" (str.++ "m" (str.++ "e" (str.++ "r" (str.++ "i" (str.++ "c" (str.++ " " (str.++ "a" (str.++ "n" (str.++ "d" (str.++ " " (str.++ "p" (str.++ "e" (str.++ "r" (str.++ "i" (str.++ "o" (str.++ "d" "")))))))))))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
