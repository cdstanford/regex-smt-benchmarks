;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([\s\S]){1,20}([\s\.])
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00BA\u00A2 \x0"
(define-fun Witness1 () String (str.++ "\u{ba}" (str.++ "\u{a2}" (str.++ " " (str.++ "\u{00}" "")))))
;witness2: "\u00FB."
(define-fun Witness2 () String (str.++ "\u{fb}" (str.++ "." "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 20) (re.range "\u{00}" "\u{ff}")) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "." ".")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
