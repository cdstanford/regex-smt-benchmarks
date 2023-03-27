;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .*-[0-9]{1,10}.*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-2\x18\u00CC\u00AD\u00EC\u00A9"
(define-fun Witness1 () String (str.++ "-" (str.++ "2" (str.++ "\u{18}" (str.++ "\u{cc}" (str.++ "\u{ad}" (str.++ "\u{ec}" (str.++ "\u{a9}" ""))))))))
;witness2: "-12\u0082@"
(define-fun Witness2 () String (str.++ "-" (str.++ "1" (str.++ "2" (str.++ "\u{82}" (str.++ "@" ""))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 1 10) (re.range "0" "9")) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
