;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((0?[1-9]|1[012])(:[0-5]\d){1,2}(\ [AaPp][Mm]))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "3:48:49 am"
(define-fun Witness1 () String (str.++ "3" (str.++ ":" (str.++ "4" (str.++ "8" (str.++ ":" (str.++ "4" (str.++ "9" (str.++ " " (str.++ "a" (str.++ "m" "")))))))))))
;witness2: "07:41:07 Am"
(define-fun Witness2 () String (str.++ "0" (str.++ "7" (str.++ ":" (str.++ "4" (str.++ "1" (str.++ ":" (str.++ "0" (str.++ "7" (str.++ " " (str.++ "A" (str.++ "m" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ ((_ re.loop 1 2) (re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9")))) (re.++ (re.range " " " ")(re.++ (re.union (re.range "A" "A")(re.union (re.range "P" "P")(re.union (re.range "a" "a") (re.range "p" "p")))) (re.union (re.range "M" "M") (re.range "m" "m")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
