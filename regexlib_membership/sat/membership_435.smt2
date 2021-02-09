;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((0[1-9])|(1[0-2]))[\/\.\-]*((0[8-9])|(1[1-9]))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "08.09"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "8" (seq.++ "." (seq.++ "0" (seq.++ "9" ""))))))
;witness2: "02.08"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "2" (seq.++ "." (seq.++ "0" (seq.++ "8" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.* (re.range "-" "/"))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "8" "9")) (re.++ (re.range "1" "1") (re.range "1" "9"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
