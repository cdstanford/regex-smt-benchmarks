;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \w{5,255}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00E0\u00D6N9\u00E0\u00FD\u00AA\u0095"
(define-fun Witness1 () String (str.++ "\u{e0}" (str.++ "\u{d6}" (str.++ "N" (str.++ "9" (str.++ "\u{e0}" (str.++ "\u{fd}" (str.++ "\u{aa}" (str.++ "\u{95}" "")))))))))
;witness2: "\u00BA83\u00E8kh__0\x13\u0097<\u00E3$@"
(define-fun Witness2 () String (str.++ "\u{ba}" (str.++ "8" (str.++ "3" (str.++ "\u{e8}" (str.++ "k" (str.++ "h" (str.++ "_" (str.++ "_" (str.++ "0" (str.++ "\u{13}" (str.++ "\u{97}" (str.++ "<" (str.++ "\u{e3}" (str.++ "$" (str.++ "@" ""))))))))))))))))

(assert (= regexA ((_ re.loop 5 255) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
