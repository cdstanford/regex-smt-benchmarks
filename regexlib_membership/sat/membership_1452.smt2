;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]{6}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "852999q"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "5" (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "q" ""))))))))
;witness2: "987884"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "8" (seq.++ "7" (seq.++ "8" (seq.++ "8" (seq.++ "4" "")))))))

(assert (= regexA (re.++ (str.to_re "") ((_ re.loop 6 6) (re.range "0" "9")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
