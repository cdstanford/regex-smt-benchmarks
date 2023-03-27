;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = "[A-Za-z0-9]{3}"
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\"k8H\"?\u00C3-"
(define-fun Witness1 () String (str.++ "\u{22}" (str.++ "k" (str.++ "8" (str.++ "H" (str.++ "\u{22}" (str.++ "?" (str.++ "\u{c3}" (str.++ "-" "")))))))))
;witness2: "\u00C82\"89J\""
(define-fun Witness2 () String (str.++ "\u{c8}" (str.++ "2" (str.++ "\u{22}" (str.++ "8" (str.++ "9" (str.++ "J" (str.++ "\u{22}" ""))))))))

(assert (= regexA (re.++ (re.range "\u{22}" "\u{22}")(re.++ ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.range "\u{22}" "\u{22}")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
