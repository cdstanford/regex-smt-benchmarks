;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{1,2}\.\d{3}\.\d{3}[-][0-9kK]{1}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "8.891.257-k"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "." (seq.++ "8" (seq.++ "9" (seq.++ "1" (seq.++ "." (seq.++ "2" (seq.++ "5" (seq.++ "7" (seq.++ "-" (seq.++ "k" ""))))))))))))
;witness2: "88.808.189-K"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "8" (seq.++ "." (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ "." (seq.++ "1" (seq.++ "8" (seq.++ "9" (seq.++ "-" (seq.++ "K" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.union (re.range "0" "9")(re.union (re.range "K" "K") (re.range "k" "k"))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
