;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(FI|HU|LU|MT|SI){0,1}[0-9]{8}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "HU39809689"
(define-fun Witness1 () String (seq.++ "H" (seq.++ "U" (seq.++ "3" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "9" (seq.++ "6" (seq.++ "8" (seq.++ "9" "")))))))))))
;witness2: "FI95908006"
(define-fun Witness2 () String (seq.++ "F" (seq.++ "I" (seq.++ "9" (seq.++ "5" (seq.++ "9" (seq.++ "0" (seq.++ "8" (seq.++ "0" (seq.++ "0" (seq.++ "6" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (str.to_re (seq.++ "F" (seq.++ "I" "")))(re.union (str.to_re (seq.++ "H" (seq.++ "U" "")))(re.union (str.to_re (seq.++ "L" (seq.++ "U" "")))(re.union (str.to_re (seq.++ "M" (seq.++ "T" ""))) (str.to_re (seq.++ "S" (seq.++ "I" ""))))))))(re.++ ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
