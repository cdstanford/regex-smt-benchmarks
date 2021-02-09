;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\([0-9]{3}\)[0-9]{3}(-)[0-9]{4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(900)888-9865"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "9" (seq.++ "0" (seq.++ "0" (seq.++ ")" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "-" (seq.++ "9" (seq.++ "8" (seq.++ "6" (seq.++ "5" ""))))))))))))))
;witness2: "(680)898-9589\u00F9Y"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "6" (seq.++ "8" (seq.++ "0" (seq.++ ")" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "-" (seq.++ "9" (seq.++ "5" (seq.++ "8" (seq.++ "9" (seq.++ "\xf9" (seq.++ "Y" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range ")" ")")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
