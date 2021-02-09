;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[89][0-9]{9}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "8638389989\u00BB\u00FA"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "6" (seq.++ "3" (seq.++ "8" (seq.++ "3" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "\xbb" (seq.++ "\xfa" "")))))))))))))
;witness2: "8571964419\xB"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "5" (seq.++ "7" (seq.++ "1" (seq.++ "9" (seq.++ "6" (seq.++ "4" (seq.++ "4" (seq.++ "1" (seq.++ "9" (seq.++ "\x0b" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "8" "9") ((_ re.loop 9 9) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
