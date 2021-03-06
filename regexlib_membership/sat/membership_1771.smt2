;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{0,2})?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "$98."
(define-fun Witness1 () String (seq.++ "$" (seq.++ "9" (seq.++ "8" (seq.++ "." "")))))
;witness2: "8,223,787,777"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "," (seq.++ "2" (seq.++ "2" (seq.++ "3" (seq.++ "," (seq.++ "7" (seq.++ "8" (seq.++ "7" (seq.++ "," (seq.++ "7" (seq.++ "7" (seq.++ "7" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "$" "$"))(re.++ (re.union (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.* (re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9"))))) (re.+ (re.range "0" "9")))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 0 2) (re.range "0" "9")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
