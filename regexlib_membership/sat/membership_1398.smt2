;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(20|21|22|23|[01]\d|\d)(([:.][0-5]\d){1,2})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "22.29"
(define-fun Witness1 () String (str.++ "2" (str.++ "2" (str.++ "." (str.++ "2" (str.++ "9" ""))))))
;witness2: "8.10"
(define-fun Witness2 () String (str.++ "8" (str.++ "." (str.++ "1" (str.++ "0" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (str.++ "2" (str.++ "0" "")))(re.union (str.to_re (str.++ "2" (str.++ "1" "")))(re.union (str.to_re (str.++ "2" (str.++ "2" "")))(re.union (str.to_re (str.++ "2" (str.++ "3" "")))(re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.range "0" "9"))))))(re.++ ((_ re.loop 1 2) (re.++ (re.union (re.range "." ".") (re.range ":" ":"))(re.++ (re.range "0" "5") (re.range "0" "9")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
