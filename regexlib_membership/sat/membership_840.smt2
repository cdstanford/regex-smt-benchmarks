;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(6011)\d{12}$)|(^(65)\d{14}$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "6548198900899820"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "5" (seq.++ "4" (seq.++ "8" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "0" (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "2" (seq.++ "0" "")))))))))))))))))
;witness2: "6549351288698198"
(define-fun Witness2 () String (seq.++ "6" (seq.++ "5" (seq.++ "4" (seq.++ "9" (seq.++ "3" (seq.++ "5" (seq.++ "1" (seq.++ "2" (seq.++ "8" (seq.++ "8" (seq.++ "6" (seq.++ "9" (seq.++ "8" (seq.++ "1" (seq.++ "9" (seq.++ "8" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "6" (seq.++ "0" (seq.++ "1" (seq.++ "1" "")))))(re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re "")))) (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "6" (seq.++ "5" "")))(re.++ ((_ re.loop 14 14) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
