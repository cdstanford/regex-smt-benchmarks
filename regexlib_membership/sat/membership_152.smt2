;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+|-)?(\d\.\d{1,6}|[1-8]\d\.\d{1,6}|90\.0{1,6})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1.9806"
(define-fun Witness1 () String (str.++ "1" (str.++ "." (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "6" "")))))))
;witness2: "-90.0"
(define-fun Witness2 () String (str.++ "-" (str.++ "9" (str.++ "0" (str.++ "." (str.++ "0" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.union (re.++ (re.range "0" "9")(re.++ (re.range "." ".") ((_ re.loop 1 6) (re.range "0" "9"))))(re.union (re.++ (re.range "1" "8")(re.++ (re.range "0" "9")(re.++ (re.range "." ".") ((_ re.loop 1 6) (re.range "0" "9"))))) (re.++ (str.to_re (str.++ "9" (str.++ "0" (str.++ "." "")))) ((_ re.loop 1 6) (re.range "0" "0"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
