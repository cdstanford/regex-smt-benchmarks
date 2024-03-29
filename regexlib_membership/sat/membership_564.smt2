;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{5}(?:\-\d{4})?)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "02848"
(define-fun Witness1 () String (str.++ "0" (str.++ "2" (str.++ "8" (str.++ "4" (str.++ "8" ""))))))
;witness2: "48889"
(define-fun Witness2 () String (str.++ "4" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "9" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 5 5) (re.range "0" "9")) (re.opt (re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
