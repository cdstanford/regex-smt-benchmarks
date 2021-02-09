;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0124678][0-9]{4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "80891"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ "1" ""))))))
;witness2: "18997"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "7" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "0" "2")(re.union (re.range "4" "4") (re.range "6" "8"))) ((_ re.loop 4 4) (re.range "0" "9"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
