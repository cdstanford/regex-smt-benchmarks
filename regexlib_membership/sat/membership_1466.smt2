;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =      |       # otherwise accept decimal number between 0 - 1048575
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "n       # otherwise accept decimal number between 0 - 1048575"
(define-fun Witness1 () String (str.++ "n" (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ "#" (str.++ " " (str.++ "o" (str.++ "t" (str.++ "h" (str.++ "e" (str.++ "r" (str.++ "w" (str.++ "i" (str.++ "s" (str.++ "e" (str.++ " " (str.++ "a" (str.++ "c" (str.++ "c" (str.++ "e" (str.++ "p" (str.++ "t" (str.++ " " (str.++ "d" (str.++ "e" (str.++ "c" (str.++ "i" (str.++ "m" (str.++ "a" (str.++ "l" (str.++ " " (str.++ "n" (str.++ "u" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" (str.++ " " (str.++ "b" (str.++ "e" (str.++ "t" (str.++ "w" (str.++ "e" (str.++ "e" (str.++ "n" (str.++ " " (str.++ "0" (str.++ " " (str.++ "-" (str.++ " " (str.++ "1" (str.++ "0" (str.++ "4" (str.++ "8" (str.++ "5" (str.++ "7" (str.++ "5" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "     "
(define-fun Witness2 () String (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " ""))))))

(assert (= regexA (re.union (str.to_re (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " "")))))) (str.to_re (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ "#" (str.++ " " (str.++ "o" (str.++ "t" (str.++ "h" (str.++ "e" (str.++ "r" (str.++ "w" (str.++ "i" (str.++ "s" (str.++ "e" (str.++ " " (str.++ "a" (str.++ "c" (str.++ "c" (str.++ "e" (str.++ "p" (str.++ "t" (str.++ " " (str.++ "d" (str.++ "e" (str.++ "c" (str.++ "i" (str.++ "m" (str.++ "a" (str.++ "l" (str.++ " " (str.++ "n" (str.++ "u" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" (str.++ " " (str.++ "b" (str.++ "e" (str.++ "t" (str.++ "w" (str.++ "e" (str.++ "e" (str.++ "n" (str.++ " " (str.++ "0" (str.++ " " (str.++ "-" (str.++ " " (str.++ "1" (str.++ "0" (str.++ "4" (str.++ "8" (str.++ "5" (str.++ "7" (str.++ "5" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
