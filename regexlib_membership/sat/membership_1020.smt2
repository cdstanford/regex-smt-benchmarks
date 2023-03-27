;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(FR){0,1}[0-9A-Z]{2}\ [0-9]{9}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9R 938175989"
(define-fun Witness1 () String (str.++ "9" (str.++ "R" (str.++ " " (str.++ "9" (str.++ "3" (str.++ "8" (str.++ "1" (str.++ "7" (str.++ "5" (str.++ "9" (str.++ "8" (str.++ "9" "")))))))))))))
;witness2: "FR99 860453689"
(define-fun Witness2 () String (str.++ "F" (str.++ "R" (str.++ "9" (str.++ "9" (str.++ " " (str.++ "8" (str.++ "6" (str.++ "0" (str.++ "4" (str.++ "5" (str.++ "3" (str.++ "6" (str.++ "8" (str.++ "9" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (str.++ "F" (str.++ "R" ""))))(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ (re.range " " " ")(re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
