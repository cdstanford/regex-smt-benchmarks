;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[+][0-9]\d{2}-\d{3}-\d{4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+380-992-9284"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "3" (seq.++ "8" (seq.++ "0" (seq.++ "-" (seq.++ "9" (seq.++ "9" (seq.++ "2" (seq.++ "-" (seq.++ "9" (seq.++ "2" (seq.++ "8" (seq.++ "4" ""))))))))))))))
;witness2: "+188-290-8748"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "1" (seq.++ "8" (seq.++ "8" (seq.++ "-" (seq.++ "2" (seq.++ "9" (seq.++ "0" (seq.++ "-" (seq.++ "8" (seq.++ "7" (seq.++ "4" (seq.++ "8" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "+" "+")(re.++ (re.range "0" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
