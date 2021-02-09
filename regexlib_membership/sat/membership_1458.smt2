;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]{2}-[0-9]{8}-[0-9]$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "46-54528984-8"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "6" (seq.++ "-" (seq.++ "5" (seq.++ "4" (seq.++ "5" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "-" (seq.++ "8" ""))))))))))))))
;witness2: "48-50399079-7"
(define-fun Witness2 () String (seq.++ "4" (seq.++ "8" (seq.++ "-" (seq.++ "5" (seq.++ "0" (seq.++ "3" (seq.++ "9" (seq.++ "9" (seq.++ "0" (seq.++ "7" (seq.++ "9" (seq.++ "-" (seq.++ "7" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 8 8) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.range "0" "9") (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
