;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([1-9]{1}[\d]{0,2}(\.[\d]{3})*(\,[\d]{0,2})?|[1-9]{1}[\d]{0,}(\,[\d]{0,2})?|0(\,[\d]{0,2})?|(\,[\d]{1,2})?)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0,0"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "," (seq.++ "0" ""))))
;witness2: "890.362,96"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "9" (seq.++ "0" (seq.++ "." (seq.++ "3" (seq.++ "6" (seq.++ "2" (seq.++ "," (seq.++ "9" (seq.++ "6" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 2) (re.range "0" "9"))(re.++ (re.* (re.++ (re.range "." ".") ((_ re.loop 3 3) (re.range "0" "9")))) (re.opt (re.++ (re.range "," ",") ((_ re.loop 0 2) (re.range "0" "9")))))))(re.union (re.++ (re.range "1" "9")(re.++ (re.* (re.range "0" "9")) (re.opt (re.++ (re.range "," ",") ((_ re.loop 0 2) (re.range "0" "9"))))))(re.union (re.++ (re.range "0" "0") (re.opt (re.++ (re.range "," ",") ((_ re.loop 0 2) (re.range "0" "9"))))) (re.opt (re.++ (re.range "," ",") ((_ re.loop 1 2) (re.range "0" "9"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
