;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = "[^"\r\n]*"
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\"\x0\"\u00C8\u00A4\x3"
(define-fun Witness1 () String (str.++ "\u{22}" (str.++ "\u{00}" (str.++ "\u{22}" (str.++ "\u{c8}" (str.++ "\u{a4}" (str.++ "\u{03}" "")))))))
;witness2: "\"\"\u00ACh"
(define-fun Witness2 () String (str.++ "\u{22}" (str.++ "\u{22}" (str.++ "\u{ac}" (str.++ "h" "")))))

(assert (= regexA (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "!") (re.range "#" "\u{ff}"))))) (re.range "\u{22}" "\u{22}")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
