;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([^S]|S[^E]|SE[^P]).*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Sx\u00AC"
(define-fun Witness1 () String (seq.++ "S" (seq.++ "x" (seq.++ "\xac" ""))))
;witness2: "\u00E6"
(define-fun Witness2 () String (seq.++ "\xe6" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.union (re.range "\x00" "R") (re.range "T" "\xff"))(re.union (re.++ (re.range "S" "S") (re.union (re.range "\x00" "D") (re.range "F" "\xff"))) (re.++ (str.to_re (seq.++ "S" (seq.++ "E" ""))) (re.union (re.range "\x00" "O") (re.range "Q" "\xff"))))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
