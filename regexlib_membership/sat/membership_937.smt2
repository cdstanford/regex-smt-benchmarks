;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[-+]?(\d?\d?\d?,?)?(\d{3}\,?)*(\.?\d+)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-,.166"
(define-fun Witness1 () String (str.++ "-" (str.++ "," (str.++ "." (str.++ "1" (str.++ "6" (str.++ "6" "")))))))
;witness2: "+99698,59543"
(define-fun Witness2 () String (str.++ "+" (str.++ "9" (str.++ "9" (str.++ "6" (str.++ "9" (str.++ "8" (str.++ "," (str.++ "5" (str.++ "9" (str.++ "5" (str.++ "4" (str.++ "3" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.opt (re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9")) (re.opt (re.range "," ","))))))(re.++ (re.* (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range "," ","))))(re.++ (re.++ (re.opt (re.range "." ".")) (re.+ (re.range "0" "9"))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
