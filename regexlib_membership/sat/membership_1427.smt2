;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \p{N}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "3\u007F\u00D8\u00AA"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "\x7f" (seq.++ "\xd8" (seq.++ "\xaa" "")))))
;witness2: "1C"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "C" "")))

(assert (= regexA (re.union (re.range "0" "9")(re.union (re.range "\xb2" "\xb3")(re.union (re.range "\xb9" "\xb9") (re.range "\xbc" "\xbe"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
