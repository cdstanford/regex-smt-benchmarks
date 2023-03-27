;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^.+\@.+\..+$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00BC\u0091@\u00F1.\u009E"
(define-fun Witness1 () String (str.++ "\u{bc}" (str.++ "\u{91}" (str.++ "@" (str.++ "\u{f1}" (str.++ "." (str.++ "\u{9e}" "")))))))
;witness2: "\u00CC@\x1.\u00F69"
(define-fun Witness2 () String (str.++ "\u{cc}" (str.++ "@" (str.++ "\u{01}" (str.++ "." (str.++ "\u{f6}" (str.++ "9" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
