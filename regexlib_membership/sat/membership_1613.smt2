;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [\\s+,]
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ",\u00DF/"
(define-fun Witness1 () String (str.++ "," (str.++ "\u{df}" (str.++ "/" ""))))
;witness2: ",\u00E6\u00F8\u0086-."
(define-fun Witness2 () String (str.++ "," (str.++ "\u{e6}" (str.++ "\u{f8}" (str.++ "\u{86}" (str.++ "-" (str.++ "." "")))))))

(assert (= regexA (re.union (re.range "+" ",")(re.union (re.range "\u{5c}" "\u{5c}") (re.range "s" "s")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
