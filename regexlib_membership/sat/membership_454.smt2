;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [-'a-zA-Z]
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "q"
(define-fun Witness1 () String (str.++ "q" ""))
;witness2: "y"
(define-fun Witness2 () String (str.++ "y" ""))

(assert (= regexA (re.union (re.range "'" "'")(re.union (re.range "-" "-")(re.union (re.range "A" "Z") (re.range "a" "z"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
