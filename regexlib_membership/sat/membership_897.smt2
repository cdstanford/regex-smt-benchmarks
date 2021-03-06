;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([1-9]{1}\d{0,2},(\d{3},)*\d{3})|([1-9]{1}\d{0,}))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "5"
(define-fun Witness1 () String (seq.++ "5" ""))
;witness2: "9,949,897"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "," (seq.++ "9" (seq.++ "4" (seq.++ "9" (seq.++ "," (seq.++ "8" (seq.++ "9" (seq.++ "7" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 2) (re.range "0" "9"))(re.++ (re.range "," ",")(re.++ (re.* (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range "," ","))) ((_ re.loop 3 3) (re.range "0" "9")))))) (re.++ (re.range "1" "9") (re.* (re.range "0" "9")))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
