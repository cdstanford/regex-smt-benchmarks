;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(LT){0,1}([0-9]{9}|[0-9]{12})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "LT888719393"
(define-fun Witness1 () String (seq.++ "L" (seq.++ "T" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "7" (seq.++ "1" (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ "3" ""))))))))))))
;witness2: "LT964859898"
(define-fun Witness2 () String (seq.++ "L" (seq.++ "T" (seq.++ "9" (seq.++ "6" (seq.++ "4" (seq.++ "8" (seq.++ "5" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "8" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (seq.++ "L" (seq.++ "T" ""))))(re.++ (re.union ((_ re.loop 9 9) (re.range "0" "9")) ((_ re.loop 12 12) (re.range "0" "9"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
