;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(352)[8-9](\d{11}$|\d{12}$))|(^(35)[3-8](\d{12}$|\d{13}$))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "3528905758887989"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "5" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "0" (seq.++ "5" (seq.++ "7" (seq.++ "5" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ "9" "")))))))))))))))))
;witness2: "3584429438333838"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "5" (seq.++ "8" (seq.++ "4" (seq.++ "4" (seq.++ "2" (seq.++ "9" (seq.++ "4" (seq.++ "3" (seq.++ "8" (seq.++ "3" (seq.++ "3" (seq.++ "3" (seq.++ "8" (seq.++ "3" (seq.++ "8" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "3" (seq.++ "5" (seq.++ "2" ""))))(re.++ (re.range "8" "9") (re.union (re.++ ((_ re.loop 11 11) (re.range "0" "9")) (str.to_re "")) (re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re "")))))) (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "3" (seq.++ "5" "")))(re.++ (re.range "3" "8") (re.union (re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re "")) (re.++ ((_ re.loop 13 13) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
