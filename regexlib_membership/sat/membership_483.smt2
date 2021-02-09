;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[:*:]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "*\u00EC"
(define-fun Witness1 () String (seq.++ "*" (seq.++ "\xec" "")))
;witness2: ":"
(define-fun Witness2 () String (seq.++ ":" ""))

(assert (= regexA (re.++ (str.to_re "") (re.union (re.range "*" "*") (re.range ":" ":")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
