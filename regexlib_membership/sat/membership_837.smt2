;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(30)[0-5]\d{11}$)|(^(36)\d{12}$)|(^(38[0-8])\d{11}$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "38583991982935"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "8" (seq.++ "5" (seq.++ "8" (seq.++ "3" (seq.++ "9" (seq.++ "9" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "2" (seq.++ "9" (seq.++ "3" (seq.++ "5" "")))))))))))))))
;witness2: "30031905985199"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "0" (seq.++ "0" (seq.++ "3" (seq.++ "1" (seq.++ "9" (seq.++ "0" (seq.++ "5" (seq.++ "9" (seq.++ "8" (seq.++ "5" (seq.++ "1" (seq.++ "9" (seq.++ "9" "")))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "3" (seq.++ "0" "")))(re.++ (re.range "0" "5")(re.++ ((_ re.loop 11 11) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "3" (seq.++ "6" "")))(re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re "")))) (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (seq.++ "3" (seq.++ "8" ""))) (re.range "0" "8"))(re.++ ((_ re.loop 11 11) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
