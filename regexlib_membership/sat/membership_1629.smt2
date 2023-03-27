;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[AaWaKkNn][a-zA-Z]?[0-9][a-zA-Z]{1,3}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "aD8X"
(define-fun Witness1 () String (str.++ "a" (str.++ "D" (str.++ "8" (str.++ "X" "")))))
;witness2: "Ws1Rz"
(define-fun Witness2 () String (str.++ "W" (str.++ "s" (str.++ "1" (str.++ "R" (str.++ "z" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "A")(re.union (re.range "K" "K")(re.union (re.range "N" "N")(re.union (re.range "W" "W")(re.union (re.range "a" "a")(re.union (re.range "k" "k") (re.range "n" "n")))))))(re.++ (re.opt (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.range "0" "9")(re.++ ((_ re.loop 1 3) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
