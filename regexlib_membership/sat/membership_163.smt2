;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([^\s]){5,12}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00AC\u00F4\u00E5!p"
(define-fun Witness1 () String (str.++ "\u{ac}" (str.++ "\u{f4}" (str.++ "\u{e5}" (str.++ "!" (str.++ "p" ""))))))
;witness2: "n\'\u008F^\x1B8\u00FD"
(define-fun Witness2 () String (str.++ "n" (str.++ "'" (str.++ "\u{8f}" (str.++ "^" (str.++ "\u{1b}" (str.++ "8" (str.++ "\u{fd}" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 5 12) (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
