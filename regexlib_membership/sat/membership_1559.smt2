;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .*[Oo0][Ee][Mm].*
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0083\u008E\u00D10Em<"
(define-fun Witness1 () String (str.++ "\u{83}" (str.++ "\u{8e}" (str.++ "\u{d1}" (str.++ "0" (str.++ "E" (str.++ "m" (str.++ "<" ""))))))))
;witness2: "C0eM"
(define-fun Witness2 () String (str.++ "C" (str.++ "0" (str.++ "e" (str.++ "M" "")))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.union (re.range "0" "0")(re.union (re.range "O" "O") (re.range "o" "o")))(re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.union (re.range "M" "M") (re.range "m" "m")) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
