;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^.+\|+[A-Za-z])
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ";\u0098\u00A2\u00B9\x6||Z"
(define-fun Witness1 () String (str.++ ";" (str.++ "\u{98}" (str.++ "\u{a2}" (str.++ "\u{b9}" (str.++ "\u{06}" (str.++ "|" (str.++ "|" (str.++ "Z" "")))))))))
;witness2: "X||z\xE\u00A8"
(define-fun Witness2 () String (str.++ "X" (str.++ "|" (str.++ "|" (str.++ "z" (str.++ "\u{0e}" (str.++ "\u{a8}" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.+ (re.range "|" "|")) (re.union (re.range "A" "Z") (re.range "a" "z")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
