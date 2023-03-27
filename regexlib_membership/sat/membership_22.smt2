;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<user>.+)@(?<domain>.+)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00F2@@"
(define-fun Witness1 () String (str.++ "\u{f2}" (str.++ "@" (str.++ "@" ""))))
;witness2: "Q@\u00E8"
(define-fun Witness2 () String (str.++ "Q" (str.++ "@" (str.++ "\u{e8}" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
