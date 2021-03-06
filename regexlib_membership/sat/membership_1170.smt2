;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{3}-\d{7}[0-6]{1}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "008-39981883"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "0" (seq.++ "8" (seq.++ "-" (seq.++ "3" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "1" (seq.++ "8" (seq.++ "8" (seq.++ "3" "")))))))))))))
;witness2: "233-97982095"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "3" (seq.++ "3" (seq.++ "-" (seq.++ "9" (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ "2" (seq.++ "0" (seq.++ "9" (seq.++ "5" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 7 7) (re.range "0" "9"))(re.++ (re.range "0" "6") (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
