;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([^S]|S[^E]|SE[^P]).*
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Sx\u00AC"
(define-fun Witness1 () String (str.++ "S" (str.++ "x" (str.++ "\u{ac}" ""))))
;witness2: "\u00E6"
(define-fun Witness2 () String (str.++ "\u{e6}" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.union (re.range "\u{00}" "R") (re.range "T" "\u{ff}"))(re.union (re.++ (re.range "S" "S") (re.union (re.range "\u{00}" "D") (re.range "F" "\u{ff}"))) (re.++ (str.to_re (str.++ "S" (str.++ "E" ""))) (re.union (re.range "\u{00}" "O") (re.range "Q" "\u{ff}"))))) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
