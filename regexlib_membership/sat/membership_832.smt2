;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(97(8|9))?\d{9}(\d|X)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "389459854X"
(define-fun Witness1 () String (str.++ "3" (str.++ "8" (str.++ "9" (str.++ "4" (str.++ "5" (str.++ "9" (str.++ "8" (str.++ "5" (str.++ "4" (str.++ "X" "")))))))))))
;witness2: "9799993961815"
(define-fun Witness2 () String (str.++ "9" (str.++ "7" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "3" (str.++ "9" (str.++ "6" (str.++ "1" (str.++ "8" (str.++ "1" (str.++ "5" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (str.to_re (str.++ "9" (str.++ "7" ""))) (re.range "8" "9")))(re.++ ((_ re.loop 9 9) (re.range "0" "9"))(re.++ (re.union (re.range "0" "9") (re.range "X" "X")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
