;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (([A-Za-z0-9_\\-]+\\.?)*)[A-Za-z0-9_\\-]+\\.[A-Za-z0-9_\\-]{2,6}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-\N\)4h"
(define-fun Witness1 () String (str.++ "-" (str.++ "\u{5c}" (str.++ "N" (str.++ "\u{5c}" (str.++ ")" (str.++ "4" (str.++ "h" ""))))))))
;witness2: "\u00D3oZ\\u00919c\u00EC\x0"
(define-fun Witness2 () String (str.++ "\u{d3}" (str.++ "o" (str.++ "Z" (str.++ "\u{5c}" (str.++ "\u{91}" (str.++ "9" (str.++ "c" (str.++ "\u{ec}" (str.++ "\u{00}" ""))))))))))

(assert (= regexA (re.++ (re.* (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.range "\u{5c}" "\u{5c}") (re.opt (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.range "\u{5c}" "\u{5c}")(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) ((_ re.loop 2 6) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
