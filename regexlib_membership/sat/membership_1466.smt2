;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =      |       # otherwise accept decimal number between 0 - 1048575
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "n       # otherwise accept decimal number between 0 - 1048575"
(define-fun Witness1 () String (seq.++ "n" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "#" (seq.++ " " (seq.++ "o" (seq.++ "t" (seq.++ "h" (seq.++ "e" (seq.++ "r" (seq.++ "w" (seq.++ "i" (seq.++ "s" (seq.++ "e" (seq.++ " " (seq.++ "a" (seq.++ "c" (seq.++ "c" (seq.++ "e" (seq.++ "p" (seq.++ "t" (seq.++ " " (seq.++ "d" (seq.++ "e" (seq.++ "c" (seq.++ "i" (seq.++ "m" (seq.++ "a" (seq.++ "l" (seq.++ " " (seq.++ "n" (seq.++ "u" (seq.++ "m" (seq.++ "b" (seq.++ "e" (seq.++ "r" (seq.++ " " (seq.++ "b" (seq.++ "e" (seq.++ "t" (seq.++ "w" (seq.++ "e" (seq.++ "e" (seq.++ "n" (seq.++ " " (seq.++ "0" (seq.++ " " (seq.++ "-" (seq.++ " " (seq.++ "1" (seq.++ "0" (seq.++ "4" (seq.++ "8" (seq.++ "5" (seq.++ "7" (seq.++ "5" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "     "
(define-fun Witness2 () String (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " ""))))))

(assert (= regexA (re.union (str.to_re (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " "")))))) (str.to_re (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "#" (seq.++ " " (seq.++ "o" (seq.++ "t" (seq.++ "h" (seq.++ "e" (seq.++ "r" (seq.++ "w" (seq.++ "i" (seq.++ "s" (seq.++ "e" (seq.++ " " (seq.++ "a" (seq.++ "c" (seq.++ "c" (seq.++ "e" (seq.++ "p" (seq.++ "t" (seq.++ " " (seq.++ "d" (seq.++ "e" (seq.++ "c" (seq.++ "i" (seq.++ "m" (seq.++ "a" (seq.++ "l" (seq.++ " " (seq.++ "n" (seq.++ "u" (seq.++ "m" (seq.++ "b" (seq.++ "e" (seq.++ "r" (seq.++ " " (seq.++ "b" (seq.++ "e" (seq.++ "t" (seq.++ "w" (seq.++ "e" (seq.++ "e" (seq.++ "n" (seq.++ " " (seq.++ "0" (seq.++ " " (seq.++ "-" (seq.++ " " (seq.++ "1" (seq.++ "0" (seq.++ "4" (seq.++ "8" (seq.++ "5" (seq.++ "7" (seq.++ "5" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
