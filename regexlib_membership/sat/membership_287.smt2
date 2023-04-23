;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^a-zA-Z0-9]+$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0094"
(define-fun Witness1 () String (str.++ "\u{94}" ""))
;witness2: "\u0097\u0086"
(define-fun Witness2 () String (str.++ "\u{97}" (str.++ "\u{86}" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "`") (re.range "{" "\u{ff}"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
