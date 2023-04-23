;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{2}|[A-Z]\d|\d[A-Z])[1-9](\d{1,3})?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "FD4"
(define-fun Witness1 () String (str.++ "F" (str.++ "D" (str.++ "4" ""))))
;witness2: "6Z989"
(define-fun Witness2 () String (str.++ "6" (str.++ "Z" (str.++ "9" (str.++ "8" (str.++ "9" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union ((_ re.loop 2 2) (re.range "A" "Z"))(re.union (re.++ (re.range "A" "Z") (re.range "0" "9")) (re.++ (re.range "0" "9") (re.range "A" "Z"))))(re.++ (re.range "1" "9")(re.++ (re.opt ((_ re.loop 1 3) (re.range "0" "9"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
