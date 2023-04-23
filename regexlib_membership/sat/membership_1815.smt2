;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ("[^"]*")|('[^\r]*)(\r\n)?
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\'\u00DF"
(define-fun Witness1 () String (str.++ "'" (str.++ "\u{df}" "")))
;witness2: "\'"
(define-fun Witness2 () String (str.++ "'" ""))

(assert (= regexA (re.union (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}"))) (re.range "\u{22}" "\u{22}"))) (re.++ (re.++ (re.range "'" "'") (re.* (re.union (re.range "\u{00}" "\u{0c}") (re.range "\u{0e}" "\u{ff}")))) (re.opt (str.to_re (str.++ "\u{0d}" (str.++ "\u{0a}" ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
