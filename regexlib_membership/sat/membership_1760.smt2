;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([1-9]{2}|[0-9][1-9]|[1-9][0-9])[0-9]{3}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "62458"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "2" (seq.++ "4" (seq.++ "5" (seq.++ "8" ""))))))
;witness2: "29807"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "7" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union ((_ re.loop 2 2) (re.range "1" "9"))(re.union (re.++ (re.range "0" "9") (re.range "1" "9")) (re.++ (re.range "1" "9") (re.range "0" "9"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
