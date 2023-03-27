;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\d{1,2})?([.][\d]{1,2})?){1}[%]{1}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ".8%"
(define-fun Witness1 () String (str.++ "." (str.++ "8" (str.++ "%" ""))))
;witness2: "83.98%"
(define-fun Witness2 () String (str.++ "8" (str.++ "3" (str.++ "." (str.++ "9" (str.++ "8" (str.++ "%" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.opt ((_ re.loop 1 2) (re.range "0" "9"))) (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 2) (re.range "0" "9")))))(re.++ (re.range "%" "%") (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
