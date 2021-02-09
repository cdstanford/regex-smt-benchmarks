;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d+\*\d+\*\d+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "6*100*1"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "*" (seq.++ "1" (seq.++ "0" (seq.++ "0" (seq.++ "*" (seq.++ "1" ""))))))))
;witness2: "1*28*2"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "*" (seq.++ "2" (seq.++ "8" (seq.++ "*" (seq.++ "2" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "*" "*")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "*" "*")(re.++ (re.+ (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
