;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = "((\\")|[^"(\\")])+"
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00C1\'\"\u00AC\"\u008C"
(define-fun Witness1 () String (str.++ "\u{c1}" (str.++ "'" (str.++ "\u{22}" (str.++ "\u{ac}" (str.++ "\u{22}" (str.++ "\u{8c}" "")))))))
;witness2: "ywH.PI\u00F9\u00A3\"\\"\""
(define-fun Witness2 () String (str.++ "y" (str.++ "w" (str.++ "H" (str.++ "." (str.++ "P" (str.++ "I" (str.++ "\u{f9}" (str.++ "\u{a3}" (str.++ "\u{22}" (str.++ "\u{5c}" (str.++ "\u{22}" (str.++ "\u{22}" "")))))))))))))

(assert (= regexA (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.+ (re.union (str.to_re (str.++ "\u{5c}" (str.++ "\u{22}" ""))) (re.union (re.range "\u{00}" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "[") (re.range "]" "\u{ff}")))))) (re.range "\u{22}" "\u{22}")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
