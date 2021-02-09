;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [\\s+,]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ",\u00DF/"
(define-fun Witness1 () String (seq.++ "," (seq.++ "\xdf" (seq.++ "/" ""))))
;witness2: ",\u00E6\u00F8\u0086-."
(define-fun Witness2 () String (seq.++ "," (seq.++ "\xe6" (seq.++ "\xf8" (seq.++ "\x86" (seq.++ "-" (seq.++ "." "")))))))

(assert (= regexA (re.union (re.range "+" ",")(re.union (re.range "\x5c" "\x5c") (re.range "s" "s")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
