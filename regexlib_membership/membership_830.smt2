;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = "(""|[^"])*"
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u009A\"\""
(define-fun Witness1 () String (str.++ "\u{9a}" (str.++ "\u{22}" (str.++ "\u{22}" ""))))
;witness2: "$\"\"\"\u00FF \""
(define-fun Witness2 () String (str.++ "$" (str.++ "\u{22}" (str.++ "\u{22}" (str.++ "\u{22}" (str.++ "\u{ff}" (str.++ " " (str.++ "\u{22}" ""))))))))

(assert (= regexA (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.union (str.to_re (str.++ "\u{22}" (str.++ "\u{22}" ""))) (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}")))) (re.range "\u{22}" "\u{22}")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
