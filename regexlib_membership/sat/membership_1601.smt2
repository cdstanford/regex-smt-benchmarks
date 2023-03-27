;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A]$|^[C]$|^[D]$|^[F]$|^[H]$|^[K]$|^[L]$|^[M]$|^[O]$|^[P]$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "H"
(define-fun Witness1 () String (str.++ "H" ""))
;witness2: "P"
(define-fun Witness2 () String (str.++ "P" ""))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "A" "A") (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "C" "C") (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "D" "D") (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "F" "F") (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "H" "H") (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "K" "K") (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "L" "L") (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "M" "M") (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "O" "O") (str.to_re ""))) (re.++ (str.to_re "")(re.++ (re.range "P" "P") (str.to_re ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
