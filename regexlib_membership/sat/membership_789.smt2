;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [0-9]{4}-([0][0-9]|[1][0-2])-([0][0-9]|[1][0-9]|[2][0-9]|[3][0-1])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "K8430-11-06"
(define-fun Witness1 () String (seq.++ "K" (seq.++ "8" (seq.++ "4" (seq.++ "3" (seq.++ "0" (seq.++ "-" (seq.++ "1" (seq.++ "1" (seq.++ "-" (seq.++ "0" (seq.++ "6" ""))))))))))))
;witness2: "3536-01-29)\u00AC"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "5" (seq.++ "3" (seq.++ "6" (seq.++ "-" (seq.++ "0" (seq.++ "1" (seq.++ "-" (seq.++ "2" (seq.++ "9" (seq.++ ")" (seq.++ "\xac" "")))))))))))))

(assert (= regexA (re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "0") (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9"))(re.union (re.++ (re.range "2" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
