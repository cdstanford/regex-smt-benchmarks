;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^04[0-9]{8}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0459890391\u0080"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "4" (seq.++ "5" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "0" (seq.++ "3" (seq.++ "9" (seq.++ "1" (seq.++ "\x80" ""))))))))))))
;witness2: "0499983374"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "4" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "3" (seq.++ "7" (seq.++ "4" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "0" (seq.++ "4" ""))) ((_ re.loop 8 8) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
