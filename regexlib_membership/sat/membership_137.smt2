;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([1-9]\d{3}|0[1-9]\d{2}|00[1-9]\d{1}|000[1-9]{1})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0688"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "6" (seq.++ "8" (seq.++ "8" "")))))
;witness2: "0903"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "9" (seq.++ "0" (seq.++ "3" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "1" "9") ((_ re.loop 3 3) (re.range "0" "9")))(re.union (re.++ (re.range "0" "0")(re.++ (re.range "1" "9") ((_ re.loop 2 2) (re.range "0" "9"))))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "0" "")))(re.++ (re.range "1" "9") (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "0" (seq.++ "0" (seq.++ "0" "")))) (re.range "1" "9"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
