;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^0*(\d{1,3}(\.?\d{3})*)\-?([\dkK])$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "00902.597k"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "0" (seq.++ "9" (seq.++ "0" (seq.++ "2" (seq.++ "." (seq.++ "5" (seq.++ "9" (seq.++ "7" (seq.++ "k" "")))))))))))
;witness2: "091-3"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "9" (seq.++ "1" (seq.++ "-" (seq.++ "3" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.range "0" "0"))(re.++ (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.* (re.++ (re.opt (re.range "." ".")) ((_ re.loop 3 3) (re.range "0" "9")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.union (re.range "0" "9")(re.union (re.range "K" "K") (re.range "k" "k"))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
