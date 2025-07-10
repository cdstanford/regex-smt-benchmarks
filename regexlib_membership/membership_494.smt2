;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\+?([1-8])?\d(\.\d+)?$)|(^-90$)|(^-(([1-8])?\d(\.\d+)?$))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-90"
(define-fun Witness1 () String (str.++ "-" (str.++ "9" (str.++ "0" ""))))
;witness2: "-8"
(define-fun Witness2 () String (str.++ "-" (str.++ "8" "")))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "+" "+"))(re.++ (re.opt (re.range "1" "8"))(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9")))) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "-" (str.++ "9" (str.++ "0" "")))) (str.to_re ""))) (re.++ (str.to_re "")(re.++ (re.range "-" "-") (re.++ (re.opt (re.range "1" "8"))(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9")))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
