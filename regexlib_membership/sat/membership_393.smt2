;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <[^>]*>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "<>"
(define-fun Witness1 () String (seq.++ "<" (seq.++ ">" "")))
;witness2: "<\u00F7\u0097>\'"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "\xf7" (seq.++ "\x97" (seq.++ ">" (seq.++ "'" ""))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff"))) (re.range ">" ">")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
