;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^5[1-5]\d{14}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "5489109935791509"
(define-fun Witness1 () String (seq.++ "5" (seq.++ "4" (seq.++ "8" (seq.++ "9" (seq.++ "1" (seq.++ "0" (seq.++ "9" (seq.++ "9" (seq.++ "3" (seq.++ "5" (seq.++ "7" (seq.++ "9" (seq.++ "1" (seq.++ "5" (seq.++ "0" (seq.++ "9" "")))))))))))))))))
;witness2: "5168852889259953"
(define-fun Witness2 () String (seq.++ "5" (seq.++ "1" (seq.++ "6" (seq.++ "8" (seq.++ "8" (seq.++ "5" (seq.++ "2" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "2" (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ "5" (seq.++ "3" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "5" "5")(re.++ (re.range "1" "5")(re.++ ((_ re.loop 14 14) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
