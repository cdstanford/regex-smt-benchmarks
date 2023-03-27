;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^.+@[^\.].*\.[a-z]{2,}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "C\u00D1\u00D1@<\u00AE.vu"
(define-fun Witness1 () String (str.++ "C" (str.++ "\u{d1}" (str.++ "\u{d1}" (str.++ "@" (str.++ "<" (str.++ "\u{ae}" (str.++ "." (str.++ "v" (str.++ "u" ""))))))))))
;witness2: "a/\u00D4\xD@\u00BC\u00E6.szu"
(define-fun Witness2 () String (str.++ "a" (str.++ "/" (str.++ "\u{d4}" (str.++ "\u{0d}" (str.++ "@" (str.++ "\u{bc}" (str.++ "\u{e6}" (str.++ "." (str.++ "s" (str.++ "z" (str.++ "u" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "@" "@")(re.++ (re.union (re.range "\u{00}" "-") (re.range "/" "\u{ff}"))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "." ".")(re.++ (re.++ ((_ re.loop 2 2) (re.range "a" "z")) (re.* (re.range "a" "z"))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
