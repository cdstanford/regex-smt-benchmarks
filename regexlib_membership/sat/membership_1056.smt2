;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((18[5-9][0-9])|((19|20)[0-9]{2})|(2100))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1878"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "8" (seq.++ "7" (seq.++ "8" "")))))
;witness2: "1874"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "8" (seq.++ "7" (seq.++ "4" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (seq.++ "1" (seq.++ "8" "")))(re.++ (re.range "5" "9") (re.range "0" "9")))(re.union (re.++ (re.union (str.to_re (seq.++ "1" (seq.++ "9" ""))) (str.to_re (seq.++ "2" (seq.++ "0" "")))) ((_ re.loop 2 2) (re.range "0" "9"))) (str.to_re (seq.++ "2" (seq.++ "1" (seq.++ "0" (seq.++ "0" ""))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
