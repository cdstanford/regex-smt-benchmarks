;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{5}-\d{2}-\d{7})*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "96239-99-953989448788-98-7928876"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "6" (seq.++ "2" (seq.++ "3" (seq.++ "9" (seq.++ "-" (seq.++ "9" (seq.++ "9" (seq.++ "-" (seq.++ "9" (seq.++ "5" (seq.++ "3" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "4" (seq.++ "4" (seq.++ "8" (seq.++ "7" (seq.++ "8" (seq.++ "8" (seq.++ "-" (seq.++ "9" (seq.++ "8" (seq.++ "-" (seq.++ "7" (seq.++ "9" (seq.++ "2" (seq.++ "8" (seq.++ "8" (seq.++ "7" (seq.++ "6" "")))))))))))))))))))))))))))))))))
;witness2: ""
(define-fun Witness2 () String "")

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 7 7) (re.range "0" "9"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)