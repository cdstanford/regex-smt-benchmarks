;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([+]|00)39)?((3[1-6][0-9]))(\d{7})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "3682073192"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "6" (seq.++ "8" (seq.++ "2" (seq.++ "0" (seq.++ "7" (seq.++ "3" (seq.++ "1" (seq.++ "9" (seq.++ "2" "")))))))))))
;witness2: "00393483298487"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "0" (seq.++ "3" (seq.++ "9" (seq.++ "3" (seq.++ "4" (seq.++ "8" (seq.++ "3" (seq.++ "2" (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "8" (seq.++ "7" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.union (re.range "+" "+") (str.to_re (seq.++ "0" (seq.++ "0" "")))) (str.to_re (seq.++ "3" (seq.++ "9" "")))))(re.++ (re.++ (re.range "3" "3")(re.++ (re.range "1" "6") (re.range "0" "9")))(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
