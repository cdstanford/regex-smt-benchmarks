;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\$?(([1-9],)?([0-9]{3},){0,3}[0-9]{3}|[0-9]{0,16})(\.[0-9]{0,3})?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "97.9"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "7" (seq.++ "." (seq.++ "9" "")))))
;witness2: "$590,293,293."
(define-fun Witness2 () String (seq.++ "$" (seq.++ "5" (seq.++ "9" (seq.++ "0" (seq.++ "," (seq.++ "2" (seq.++ "9" (seq.++ "3" (seq.++ "," (seq.++ "2" (seq.++ "9" (seq.++ "3" (seq.++ "." ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "$" "$"))(re.++ (re.union (re.++ (re.opt (re.++ (re.range "1" "9") (re.range "," ",")))(re.++ ((_ re.loop 0 3) (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range "," ","))) ((_ re.loop 3 3) (re.range "0" "9")))) ((_ re.loop 0 16) (re.range "0" "9")))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 0 3) (re.range "0" "9")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
