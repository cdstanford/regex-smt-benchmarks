;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{8,8}$|^[SC]{2,2}\d{6,6}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "09888978"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "7" (seq.++ "8" "")))))))))
;witness2: "82940077"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "2" (seq.++ "9" (seq.++ "4" (seq.++ "0" (seq.++ "0" (seq.++ "7" (seq.++ "7" "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re ""))) (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.union (re.range "C" "C") (re.range "S" "S")))(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
