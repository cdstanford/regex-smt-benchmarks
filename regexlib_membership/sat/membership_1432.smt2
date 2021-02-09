;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \u00A3
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00CBt\u00A3\u008E\"
(define-fun Witness1 () String (seq.++ "\xcb" (seq.++ "t" (seq.++ "\xa3" (seq.++ "\x8e" (seq.++ "\x5c" ""))))))
;witness2: "x\u00A3\u00E5\u009D\x4"
(define-fun Witness2 () String (seq.++ "x" (seq.++ "\xa3" (seq.++ "\xe5" (seq.++ "\x9d" (seq.++ "\x04" ""))))))

(assert (= regexA (re.range "\xa3" "\xa3")))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
