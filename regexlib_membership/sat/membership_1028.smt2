;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(FI|HU|LU|MT|SI){0,1}[0-9]{8}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "HU39809689"
(define-fun Witness1 () String (str.++ "H" (str.++ "U" (str.++ "3" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "9" (str.++ "6" (str.++ "8" (str.++ "9" "")))))))))))
;witness2: "FI95908006"
(define-fun Witness2 () String (str.++ "F" (str.++ "I" (str.++ "9" (str.++ "5" (str.++ "9" (str.++ "0" (str.++ "8" (str.++ "0" (str.++ "0" (str.++ "6" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (str.to_re (str.++ "F" (str.++ "I" "")))(re.union (str.to_re (str.++ "H" (str.++ "U" "")))(re.union (str.to_re (str.++ "L" (str.++ "U" "")))(re.union (str.to_re (str.++ "M" (str.++ "T" ""))) (str.to_re (str.++ "S" (str.++ "I" ""))))))))(re.++ ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
