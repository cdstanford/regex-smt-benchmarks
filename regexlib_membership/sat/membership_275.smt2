;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\d{8})|(\d{10})|(\d{11})|(\d{6}-\d{5}))?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9889688898"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "6" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "8" "")))))))))))
;witness2: ""
(define-fun Witness2 () String "")

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union ((_ re.loop 8 8) (re.range "0" "9"))(re.union ((_ re.loop 10 10) (re.range "0" "9"))(re.union ((_ re.loop 11 11) (re.range "0" "9")) (re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 5 5) (re.range "0" "9")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
