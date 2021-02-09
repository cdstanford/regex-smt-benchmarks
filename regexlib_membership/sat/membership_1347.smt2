;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((2|8|9)\d{2})|((02|08|09)\d{2})|([1-9]\d{3}))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0290"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "2" (seq.++ "9" (seq.++ "0" "")))))
;witness2: "0208"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "2" (seq.++ "0" (seq.++ "8" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "2" "2") (re.range "8" "9")) ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.union (str.to_re (seq.++ "0" (seq.++ "2" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "8" ""))) (str.to_re (seq.++ "0" (seq.++ "9" ""))))) ((_ re.loop 2 2) (re.range "0" "9"))) (re.++ (re.range "1" "9") ((_ re.loop 3 3) (re.range "0" "9"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
