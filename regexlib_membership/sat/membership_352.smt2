;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ('(?:(?:\\'|[^'])*)'|NULL)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "NULL"
(define-fun Witness1 () String (seq.++ "N" (seq.++ "U" (seq.++ "L" (seq.++ "L" "")))))
;witness2: "\xDc\x0y\'\u00C6\x16\'"
(define-fun Witness2 () String (seq.++ "\x0d" (seq.++ "c" (seq.++ "\x00" (seq.++ "y" (seq.++ "'" (seq.++ "\xc6" (seq.++ "\x16" (seq.++ "'" "")))))))))

(assert (= regexA (re.union (re.++ (re.range "'" "'")(re.++ (re.* (re.union (str.to_re (seq.++ "\x5c" (seq.++ "'" ""))) (re.union (re.range "\x00" "&") (re.range "(" "\xff")))) (re.range "'" "'"))) (str.to_re (seq.++ "N" (seq.++ "U" (seq.++ "L" (seq.++ "L" ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
