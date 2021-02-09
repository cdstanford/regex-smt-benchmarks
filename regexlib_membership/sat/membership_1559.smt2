;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .*[Oo0][Ee][Mm].*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0083\u008E\u00D10Em<"
(define-fun Witness1 () String (seq.++ "\x83" (seq.++ "\x8e" (seq.++ "\xd1" (seq.++ "0" (seq.++ "E" (seq.++ "m" (seq.++ "<" ""))))))))
;witness2: "C0eM"
(define-fun Witness2 () String (seq.++ "C" (seq.++ "0" (seq.++ "e" (seq.++ "M" "")))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.union (re.range "0" "0")(re.union (re.range "O" "O") (re.range "o" "o")))(re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.union (re.range "M" "M") (re.range "m" "m")) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
