;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Validation of Mexican RFC for tax payers (individuals)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Validation of Mexican RFC for tax payers individuals"
(define-fun Witness1 () String (str.++ "V" (str.++ "a" (str.++ "l" (str.++ "i" (str.++ "d" (str.++ "a" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ " " (str.++ "o" (str.++ "f" (str.++ " " (str.++ "M" (str.++ "e" (str.++ "x" (str.++ "i" (str.++ "c" (str.++ "a" (str.++ "n" (str.++ " " (str.++ "R" (str.++ "F" (str.++ "C" (str.++ " " (str.++ "f" (str.++ "o" (str.++ "r" (str.++ " " (str.++ "t" (str.++ "a" (str.++ "x" (str.++ " " (str.++ "p" (str.++ "a" (str.++ "y" (str.++ "e" (str.++ "r" (str.++ "s" (str.++ " " (str.++ "i" (str.++ "n" (str.++ "d" (str.++ "i" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "u" (str.++ "a" (str.++ "l" (str.++ "s" "")))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "L[\u00CEValidation of Mexican RFC for tax payers individualsY"
(define-fun Witness2 () String (str.++ "L" (str.++ "[" (str.++ "\u{ce}" (str.++ "V" (str.++ "a" (str.++ "l" (str.++ "i" (str.++ "d" (str.++ "a" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ " " (str.++ "o" (str.++ "f" (str.++ " " (str.++ "M" (str.++ "e" (str.++ "x" (str.++ "i" (str.++ "c" (str.++ "a" (str.++ "n" (str.++ " " (str.++ "R" (str.++ "F" (str.++ "C" (str.++ " " (str.++ "f" (str.++ "o" (str.++ "r" (str.++ " " (str.++ "t" (str.++ "a" (str.++ "x" (str.++ " " (str.++ "p" (str.++ "a" (str.++ "y" (str.++ "e" (str.++ "r" (str.++ "s" (str.++ " " (str.++ "i" (str.++ "n" (str.++ "d" (str.++ "i" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "u" (str.++ "a" (str.++ "l" (str.++ "s" (str.++ "Y" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "V" (str.++ "a" (str.++ "l" (str.++ "i" (str.++ "d" (str.++ "a" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ " " (str.++ "o" (str.++ "f" (str.++ " " (str.++ "M" (str.++ "e" (str.++ "x" (str.++ "i" (str.++ "c" (str.++ "a" (str.++ "n" (str.++ " " (str.++ "R" (str.++ "F" (str.++ "C" (str.++ " " (str.++ "f" (str.++ "o" (str.++ "r" (str.++ " " (str.++ "t" (str.++ "a" (str.++ "x" (str.++ " " (str.++ "p" (str.++ "a" (str.++ "y" (str.++ "e" (str.++ "r" (str.++ "s" (str.++ " " "")))))))))))))))))))))))))))))))))))))))))) (str.to_re (str.++ "i" (str.++ "n" (str.++ "d" (str.++ "i" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "u" (str.++ "a" (str.++ "l" (str.++ "s" "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
