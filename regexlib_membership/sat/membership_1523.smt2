;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [^A-Za-z0-9]
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x6f$\u00BB`\'"
(define-fun Witness1 () String (str.++ "\u{06}" (str.++ "f" (str.++ "$" (str.++ "\u{bb}" (str.++ "`" (str.++ "'" "")))))))
;witness2: "`\u00FF\u008E"
(define-fun Witness2 () String (str.++ "`" (str.++ "\u{ff}" (str.++ "\u{8e}" ""))))

(assert (= regexA (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "`") (re.range "{" "\u{ff}"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
