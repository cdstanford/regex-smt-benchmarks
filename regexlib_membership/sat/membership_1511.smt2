;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .\{\d\}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "I{9}"
(define-fun Witness1 () String (seq.++ "I" (seq.++ "{" (seq.++ "9" (seq.++ "}" "")))))
;witness2: "\u00F5\u00AA\u00D8\u008D{8}"
(define-fun Witness2 () String (seq.++ "\xf5" (seq.++ "\xaa" (seq.++ "\xd8" (seq.++ "\x8d" (seq.++ "{" (seq.++ "8" (seq.++ "}" ""))))))))

(assert (= regexA (re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.range "{" "{")(re.++ (re.range "0" "9") (re.range "}" "}"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
