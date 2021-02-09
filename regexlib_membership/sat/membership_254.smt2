;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0]{0,1}[0-7]{3})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0033"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "0" (seq.++ "3" (seq.++ "3" "")))))
;witness2: "037"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "3" (seq.++ "7" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "0" "0")) ((_ re.loop 3 3) (re.range "0" "7"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
