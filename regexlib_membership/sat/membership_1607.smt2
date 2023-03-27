;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^<>`~!/@\#}$%:;)(_^{&*=|'+]+$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00DA\u00BAV\u00A9\u009D"
(define-fun Witness1 () String (str.++ "\u{da}" (str.++ "\u{ba}" (str.++ "V" (str.++ "\u{a9}" (str.++ "\u{9d}" ""))))))
;witness2: "\u00E1"
(define-fun Witness2 () String (str.++ "\u{e1}" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\u{00}" " ")(re.union (re.range "\u{22}" "\u{22}")(re.union (re.range "," ".")(re.union (re.range "0" "9")(re.union (re.range "?" "?")(re.union (re.range "A" "]")(re.union (re.range "a" "z") (re.range "\u{7f}" "\u{ff}"))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
