;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([1-9]([0-9])?)(\.(([0])?|([1-9])?|[1]([0-1])?)?)?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "99."
(define-fun Witness1 () String (str.++ "9" (str.++ "9" (str.++ "." ""))))
;witness2: "4.11"
(define-fun Witness2 () String (str.++ "4" (str.++ "." (str.++ "1" (str.++ "1" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.range "1" "9") (re.opt (re.range "0" "9")))(re.++ (re.opt (re.++ (re.range "." ".") (re.opt (re.union (re.opt (re.range "0" "0"))(re.union (re.opt (re.range "1" "9")) (re.++ (re.range "1" "1") (re.opt (re.range "0" "1")))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
