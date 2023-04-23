;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[-+]?(\d?\d?\d?,?)?(\d{3}\,?)*(\.\d{1,2})?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+69.8"
(define-fun Witness1 () String (str.++ "+" (str.++ "6" (str.++ "9" (str.++ "." (str.++ "8" ""))))))
;witness2: "93"
(define-fun Witness2 () String (str.++ "9" (str.++ "3" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.opt (re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9")) (re.opt (re.range "," ","))))))(re.++ (re.* (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range "," ","))))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 2) (re.range "0" "9")))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
