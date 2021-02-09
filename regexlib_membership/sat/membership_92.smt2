;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:Error|Warning|Exception)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Exception\u00A0\u00B6"
(define-fun Witness1 () String (seq.++ "E" (seq.++ "x" (seq.++ "c" (seq.++ "e" (seq.++ "p" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ "\xa0" (seq.++ "\xb6" ""))))))))))))
;witness2: "Exception"
(define-fun Witness2 () String (seq.++ "E" (seq.++ "x" (seq.++ "c" (seq.++ "e" (seq.++ "p" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" ""))))))))))

(assert (= regexA (re.union (str.to_re (seq.++ "E" (seq.++ "r" (seq.++ "r" (seq.++ "o" (seq.++ "r" ""))))))(re.union (str.to_re (seq.++ "W" (seq.++ "a" (seq.++ "r" (seq.++ "n" (seq.++ "i" (seq.++ "n" (seq.++ "g" "")))))))) (str.to_re (seq.++ "E" (seq.++ "x" (seq.++ "c" (seq.++ "e" (seq.++ "p" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
