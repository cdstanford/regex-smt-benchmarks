;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Validation of Mexican RFC for tax payers (individuals)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Validation of Mexican RFC for tax payers individuals"
(define-fun Witness1 () String (seq.++ "V" (seq.++ "a" (seq.++ "l" (seq.++ "i" (seq.++ "d" (seq.++ "a" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ " " (seq.++ "o" (seq.++ "f" (seq.++ " " (seq.++ "M" (seq.++ "e" (seq.++ "x" (seq.++ "i" (seq.++ "c" (seq.++ "a" (seq.++ "n" (seq.++ " " (seq.++ "R" (seq.++ "F" (seq.++ "C" (seq.++ " " (seq.++ "f" (seq.++ "o" (seq.++ "r" (seq.++ " " (seq.++ "t" (seq.++ "a" (seq.++ "x" (seq.++ " " (seq.++ "p" (seq.++ "a" (seq.++ "y" (seq.++ "e" (seq.++ "r" (seq.++ "s" (seq.++ " " (seq.++ "i" (seq.++ "n" (seq.++ "d" (seq.++ "i" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "u" (seq.++ "a" (seq.++ "l" (seq.++ "s" "")))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "L[\u00CEValidation of Mexican RFC for tax payers individualsY"
(define-fun Witness2 () String (seq.++ "L" (seq.++ "[" (seq.++ "\xce" (seq.++ "V" (seq.++ "a" (seq.++ "l" (seq.++ "i" (seq.++ "d" (seq.++ "a" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ " " (seq.++ "o" (seq.++ "f" (seq.++ " " (seq.++ "M" (seq.++ "e" (seq.++ "x" (seq.++ "i" (seq.++ "c" (seq.++ "a" (seq.++ "n" (seq.++ " " (seq.++ "R" (seq.++ "F" (seq.++ "C" (seq.++ " " (seq.++ "f" (seq.++ "o" (seq.++ "r" (seq.++ " " (seq.++ "t" (seq.++ "a" (seq.++ "x" (seq.++ " " (seq.++ "p" (seq.++ "a" (seq.++ "y" (seq.++ "e" (seq.++ "r" (seq.++ "s" (seq.++ " " (seq.++ "i" (seq.++ "n" (seq.++ "d" (seq.++ "i" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "u" (seq.++ "a" (seq.++ "l" (seq.++ "s" (seq.++ "Y" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "V" (seq.++ "a" (seq.++ "l" (seq.++ "i" (seq.++ "d" (seq.++ "a" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ " " (seq.++ "o" (seq.++ "f" (seq.++ " " (seq.++ "M" (seq.++ "e" (seq.++ "x" (seq.++ "i" (seq.++ "c" (seq.++ "a" (seq.++ "n" (seq.++ " " (seq.++ "R" (seq.++ "F" (seq.++ "C" (seq.++ " " (seq.++ "f" (seq.++ "o" (seq.++ "r" (seq.++ " " (seq.++ "t" (seq.++ "a" (seq.++ "x" (seq.++ " " (seq.++ "p" (seq.++ "a" (seq.++ "y" (seq.++ "e" (seq.++ "r" (seq.++ "s" (seq.++ " " "")))))))))))))))))))))))))))))))))))))))))) (str.to_re (seq.++ "i" (seq.++ "n" (seq.++ "d" (seq.++ "i" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "u" (seq.++ "a" (seq.++ "l" (seq.++ "s" "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
