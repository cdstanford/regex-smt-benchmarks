;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z0-9!@#$%^&amp;*()-_=+;:'&quot;|~`&lt;&gt;?/{}]{1,5})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "2"
(define-fun Witness1 () String (seq.++ "2" ""))
;witness2: "4yb"
(define-fun Witness2 () String (seq.++ "4" (seq.++ "y" (seq.++ "b" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 5) (re.union (re.range "!" "!") (re.range "#" "~"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
