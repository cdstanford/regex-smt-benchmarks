;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-1][0-9]|[2][0-3]|[0-9]):([0-5][0-9])(?::([0-5][0-9]))?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "22:22:39"
(define-fun Witness1 () String (str.++ "2" (str.++ "2" (str.++ ":" (str.++ "2" (str.++ "2" (str.++ ":" (str.++ "3" (str.++ "9" "")))))))))
;witness2: "19:59"
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ ":" (str.++ "5" (str.++ "9" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9"))(re.union (re.++ (re.range "2" "2") (re.range "0" "3")) (re.range "0" "9")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.opt (re.++ (re.range ":" ":") (re.++ (re.range "0" "5") (re.range "0" "9")))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
