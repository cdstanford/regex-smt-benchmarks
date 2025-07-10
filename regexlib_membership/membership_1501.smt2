;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z].*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "OQ$"
(define-fun Witness1 () String (str.++ "O" (str.++ "Q" (str.++ "$" ""))))
;witness2: "M"
(define-fun Witness2 () String (str.++ "M" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "A" "Z")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
