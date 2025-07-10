;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [a-zA-Z0-9_\\-]+@([a-zA-Z0-9_\\-]+\\.)+(com)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "P@99\X4\\x1F9Q\(com"
(define-fun Witness1 () String (str.++ "P" (str.++ "@" (str.++ "9" (str.++ "9" (str.++ "\u{5c}" (str.++ "X" (str.++ "4" (str.++ "\u{5c}" (str.++ "\u{1f}" (str.++ "9" (str.++ "Q" (str.++ "\u{5c}" (str.++ "(" (str.++ "c" (str.++ "o" (str.++ "m" "")))))))))))))))))
;witness2: "\u00F4\u008D4@y\|Z\tn\e3d8g\\u008Bb\\u00B3comW"
(define-fun Witness2 () String (str.++ "\u{f4}" (str.++ "\u{8d}" (str.++ "4" (str.++ "@" (str.++ "y" (str.++ "\u{5c}" (str.++ "|" (str.++ "Z" (str.++ "\u{5c}" (str.++ "t" (str.++ "n" (str.++ "\u{5c}" (str.++ "e" (str.++ "3" (str.++ "d" (str.++ "8" (str.++ "g" (str.++ "\u{5c}" (str.++ "\u{8b}" (str.++ "b" (str.++ "\u{5c}" (str.++ "\u{b3}" (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "W" "")))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.range "\u{5c}" "\u{5c}") (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))) (str.to_re (str.++ "c" (str.++ "o" (str.++ "m" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
