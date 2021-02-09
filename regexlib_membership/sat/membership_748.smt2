;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\$\d{1,3}(,?\d{3})*(\.\d{2})?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "$889565,299"
(define-fun Witness1 () String (seq.++ "$" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "5" (seq.++ "6" (seq.++ "5" (seq.++ "," (seq.++ "2" (seq.++ "9" (seq.++ "9" ""))))))))))))
;witness2: "$3286989,848,998.98"
(define-fun Witness2 () String (seq.++ "$" (seq.++ "3" (seq.++ "2" (seq.++ "8" (seq.++ "6" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "," (seq.++ "8" (seq.++ "4" (seq.++ "8" (seq.++ "," (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "." (seq.++ "9" (seq.++ "8" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "$" "$")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.* (re.++ (re.opt (re.range "," ",")) ((_ re.loop 3 3) (re.range "0" "9"))))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 2 2) (re.range "0" "9")))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
