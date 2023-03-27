;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ('(?:(?:\\'|[^'])*)'|NULL)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "NULL"
(define-fun Witness1 () String (str.++ "N" (str.++ "U" (str.++ "L" (str.++ "L" "")))))
;witness2: "\xDc\x0y\'\u00C6\x16\'"
(define-fun Witness2 () String (str.++ "\u{0d}" (str.++ "c" (str.++ "\u{00}" (str.++ "y" (str.++ "'" (str.++ "\u{c6}" (str.++ "\u{16}" (str.++ "'" "")))))))))

(assert (= regexA (re.union (re.++ (re.range "'" "'")(re.++ (re.* (re.union (str.to_re (str.++ "\u{5c}" (str.++ "'" ""))) (re.union (re.range "\u{00}" "&") (re.range "(" "\u{ff}")))) (re.range "'" "'"))) (str.to_re (str.++ "N" (str.++ "U" (str.++ "L" (str.++ "L" ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
