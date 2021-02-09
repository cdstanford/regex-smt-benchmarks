;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^[0][2][1579]{1})(\d{6,7}$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "021168379"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "2" (seq.++ "1" (seq.++ "1" (seq.++ "6" (seq.++ "8" (seq.++ "3" (seq.++ "7" (seq.++ "9" ""))))))))))
;witness2: "0218492315"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "2" (seq.++ "1" (seq.++ "8" (seq.++ "4" (seq.++ "9" (seq.++ "2" (seq.++ "3" (seq.++ "1" (seq.++ "5" "")))))))))))

(assert (= regexA (re.++ (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "0" (seq.++ "2" ""))) (re.union (re.range "1" "1")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9")))))) (re.++ ((_ re.loop 6 7) (re.range "0" "9")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
