;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [a-zA-Z0-9]*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "V`\u00A4!"
(define-fun Witness1 () String (seq.++ "V" (seq.++ "`" (seq.++ "\xa4" (seq.++ "!" "")))))
;witness2: "\xEEo"
(define-fun Witness2 () String (seq.++ "\x0e" (seq.++ "E" (seq.++ "o" ""))))

(assert (= regexA (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
