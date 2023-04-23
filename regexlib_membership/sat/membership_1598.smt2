;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[-]?([1-9]{1}[0-9]{0,}(\.[0-9]{0,2})?|0(\.[0-9]{0,2})?|\.[0-9]{1,2})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-0"
(define-fun Witness1 () String (str.++ "-" (str.++ "0" "")))
;witness2: "-.9"
(define-fun Witness2 () String (str.++ "-" (str.++ "." (str.++ "9" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "-" "-"))(re.++ (re.union (re.++ (re.range "1" "9")(re.++ (re.* (re.range "0" "9")) (re.opt (re.++ (re.range "." ".") ((_ re.loop 0 2) (re.range "0" "9"))))))(re.union (re.++ (re.range "0" "0") (re.opt (re.++ (re.range "." ".") ((_ re.loop 0 2) (re.range "0" "9"))))) (re.++ (re.range "." ".") ((_ re.loop 1 2) (re.range "0" "9"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
