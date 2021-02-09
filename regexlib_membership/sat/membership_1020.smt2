;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(FR){0,1}[0-9A-Z]{2}\ [0-9]{9}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9R 938175989"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "R" (seq.++ " " (seq.++ "9" (seq.++ "3" (seq.++ "8" (seq.++ "1" (seq.++ "7" (seq.++ "5" (seq.++ "9" (seq.++ "8" (seq.++ "9" "")))))))))))))
;witness2: "FR99 860453689"
(define-fun Witness2 () String (seq.++ "F" (seq.++ "R" (seq.++ "9" (seq.++ "9" (seq.++ " " (seq.++ "8" (seq.++ "6" (seq.++ "0" (seq.++ "4" (seq.++ "5" (seq.++ "3" (seq.++ "6" (seq.++ "8" (seq.++ "9" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (seq.++ "F" (seq.++ "R" ""))))(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ (re.range " " " ")(re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
