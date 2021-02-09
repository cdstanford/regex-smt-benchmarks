;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[1-9]\d?-\d{7}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "28-9985999"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "8" (seq.++ "-" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ "9" "")))))))))))
;witness2: "8-6507902"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "-" (seq.++ "6" (seq.++ "5" (seq.++ "0" (seq.++ "7" (seq.++ "9" (seq.++ "0" (seq.++ "2" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "1" "9")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
