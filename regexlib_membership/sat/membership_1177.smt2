;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [AaEeIiOoUuYy]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u008Cu\u00E1\u00A4"
(define-fun Witness1 () String (seq.++ "\x8c" (seq.++ "u" (seq.++ "\xe1" (seq.++ "\xa4" "")))))
;witness2: "\u0093k4Wy"
(define-fun Witness2 () String (seq.++ "\x93" (seq.++ "k" (seq.++ "4" (seq.++ "W" (seq.++ "y" ""))))))

(assert (= regexA (re.union (re.range "A" "A")(re.union (re.range "E" "E")(re.union (re.range "I" "I")(re.union (re.range "O" "O")(re.union (re.range "U" "U")(re.union (re.range "Y" "Y")(re.union (re.range "a" "a")(re.union (re.range "e" "e")(re.union (re.range "i" "i")(re.union (re.range "o" "o")(re.union (re.range "u" "u") (re.range "y" "y"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
