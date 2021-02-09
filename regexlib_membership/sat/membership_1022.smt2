;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(DK){0,1}([0-9]{2}\ ){3}[0-9]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "68 78 54 05"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "8" (seq.++ " " (seq.++ "7" (seq.++ "8" (seq.++ " " (seq.++ "5" (seq.++ "4" (seq.++ " " (seq.++ "0" (seq.++ "5" ""))))))))))))
;witness2: "DK98 67 89 33"
(define-fun Witness2 () String (seq.++ "D" (seq.++ "K" (seq.++ "9" (seq.++ "8" (seq.++ " " (seq.++ "6" (seq.++ "7" (seq.++ " " (seq.++ "8" (seq.++ "9" (seq.++ " " (seq.++ "3" (seq.++ "3" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (seq.++ "D" (seq.++ "K" ""))))(re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.range " " " ")))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
