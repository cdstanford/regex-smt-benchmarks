;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([8-9])([1-9])(\d{2})(-?|\040?)(\d{4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "98266772"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "8" (seq.++ "2" (seq.++ "6" (seq.++ "6" (seq.++ "7" (seq.++ "7" (seq.++ "2" "")))))))))
;witness2: "8145 9988"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "1" (seq.++ "4" (seq.++ "5" (seq.++ " " (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "8" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "8" "9")(re.++ (re.range "1" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.opt (re.range "-" "-")) (re.opt (re.range " " " ")))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
