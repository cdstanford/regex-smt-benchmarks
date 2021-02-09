;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\+?972(\-)?0?[23489]{1}(\-)?[^0\D]{1}\d{6}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+972023829154"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "9" (seq.++ "7" (seq.++ "2" (seq.++ "0" (seq.++ "2" (seq.++ "3" (seq.++ "8" (seq.++ "2" (seq.++ "9" (seq.++ "1" (seq.++ "5" (seq.++ "4" ""))))))))))))))
;witness2: "9728-8989834"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "7" (seq.++ "2" (seq.++ "8" (seq.++ "-" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "4" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "+" "+"))(re.++ (str.to_re (seq.++ "9" (seq.++ "7" (seq.++ "2" ""))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "0" "0"))(re.++ (re.union (re.range "2" "4") (re.range "8" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
