;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{2,3}|\(\d{2,3}\))[ ]?\d{3,4}[-]?\d{3,4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "897 9968987"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "9" (seq.++ "7" (seq.++ " " (seq.++ "9" (seq.++ "9" (seq.++ "6" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "7" ""))))))))))))
;witness2: "96 1083525"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "6" (seq.++ " " (seq.++ "1" (seq.++ "0" (seq.++ "8" (seq.++ "3" (seq.++ "5" (seq.++ "2" (seq.++ "5" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union ((_ re.loop 2 3) (re.range "0" "9")) (re.++ (re.range "(" "(")(re.++ ((_ re.loop 2 3) (re.range "0" "9")) (re.range ")" ")"))))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 3 4) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 3 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
