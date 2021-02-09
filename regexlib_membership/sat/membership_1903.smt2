;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{5}-\d{4}|\d{5}|[A-Z]\d[A-Z] \d[A-Z]\d$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "2Z2F 5W0"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "Z" (seq.++ "2" (seq.++ "F" (seq.++ " " (seq.++ "5" (seq.++ "W" (seq.++ "0" "")))))))))
;witness2: "57908-1799"
(define-fun Witness2 () String (seq.++ "5" (seq.++ "7" (seq.++ "9" (seq.++ "0" (seq.++ "8" (seq.++ "-" (seq.++ "1" (seq.++ "7" (seq.++ "9" (seq.++ "9" "")))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))))(re.union ((_ re.loop 5 5) (re.range "0" "9")) (re.++ (re.range "A" "Z")(re.++ (re.range "0" "9")(re.++ (re.range "A" "Z")(re.++ (re.range " " " ")(re.++ (re.range "0" "9")(re.++ (re.range "A" "Z")(re.++ (re.range "0" "9") (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
