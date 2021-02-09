;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(0[1-9]|[12][0-9]|3[01])-(0[1-9]|11|12|10)-(19[0-9]{2})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "05-10-1907"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "5" (seq.++ "-" (seq.++ "1" (seq.++ "0" (seq.++ "-" (seq.++ "1" (seq.++ "9" (seq.++ "0" (seq.++ "7" "")))))))))))
;witness2: "31-11-1930"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "1" (seq.++ "-" (seq.++ "1" (seq.++ "1" (seq.++ "-" (seq.++ "1" (seq.++ "9" (seq.++ "3" (seq.++ "0" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (str.to_re (seq.++ "1" (seq.++ "1" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "2" ""))) (str.to_re (seq.++ "1" (seq.++ "0" ""))))))(re.++ (re.range "-" "-")(re.++ (re.++ (str.to_re (seq.++ "1" (seq.++ "9" ""))) ((_ re.loop 2 2) (re.range "0" "9"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
