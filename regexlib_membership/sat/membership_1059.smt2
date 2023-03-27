;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(N[BLSTU]|[AMN]B|[BQ]C|ON|PE|SK)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "SK"
(define-fun Witness1 () String (str.++ "S" (str.++ "K" "")))
;witness2: "AB"
(define-fun Witness2 () String (str.++ "A" (str.++ "B" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "N" "N") (re.union (re.range "B" "B")(re.union (re.range "L" "L") (re.range "S" "U"))))(re.union (re.++ (re.union (re.range "A" "A") (re.range "M" "N")) (re.range "B" "B"))(re.union (re.++ (re.union (re.range "B" "B") (re.range "Q" "Q")) (re.range "C" "C"))(re.union (str.to_re (str.++ "O" (str.++ "N" "")))(re.union (str.to_re (str.++ "P" (str.++ "E" ""))) (str.to_re (str.++ "S" (str.++ "K" "")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
