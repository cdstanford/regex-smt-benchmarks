;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\d)?(\d{1})(\.{1})(\d)?(\d{1})){1}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0.09"
(define-fun Witness1 () String (str.++ "0" (str.++ "." (str.++ "0" (str.++ "9" "")))))
;witness2: "9.5"
(define-fun Witness2 () String (str.++ "9" (str.++ "." (str.++ "5" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "0" "9"))(re.++ (re.range "0" "9")(re.++ (re.range "." ".")(re.++ (re.opt (re.range "0" "9")) (re.range "0" "9"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
