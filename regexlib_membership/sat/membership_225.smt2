;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((0|128|192|224|240|248|252|254).0.0.0)|(255.(0|128|192|224|240|248|252|254).0.0)|(255.255.(0|128|192|224|240|248|252|254).0)|(255.255.255.(0|128|192|224|240|248|252|254)))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "252W0\u00C40\u00EA0"
(define-fun Witness1 () String (str.++ "2" (str.++ "5" (str.++ "2" (str.++ "W" (str.++ "0" (str.++ "\u{c4}" (str.++ "0" (str.++ "\u{ea}" (str.++ "0" ""))))))))))
;witness2: "192O0\u00CB0$0"
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ "2" (str.++ "O" (str.++ "0" (str.++ "\u{cb}" (str.++ "0" (str.++ "$" (str.++ "0" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "0" "0")(re.union (str.to_re (str.++ "1" (str.++ "2" (str.++ "8" ""))))(re.union (str.to_re (str.++ "1" (str.++ "9" (str.++ "2" ""))))(re.union (str.to_re (str.++ "2" (str.++ "2" (str.++ "4" ""))))(re.union (str.to_re (str.++ "2" (str.++ "4" (str.++ "0" ""))))(re.union (str.to_re (str.++ "2" (str.++ "4" (str.++ "8" ""))))(re.union (str.to_re (str.++ "2" (str.++ "5" (str.++ "2" "")))) (str.to_re (str.++ "2" (str.++ "5" (str.++ "4" "")))))))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.range "0" "0")(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.range "0" "0")(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (re.range "0" "0")))))))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" (str.++ "5" ""))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.union (re.range "0" "0")(re.union (str.to_re (str.++ "1" (str.++ "2" (str.++ "8" ""))))(re.union (str.to_re (str.++ "1" (str.++ "9" (str.++ "2" ""))))(re.union (str.to_re (str.++ "2" (str.++ "2" (str.++ "4" ""))))(re.union (str.to_re (str.++ "2" (str.++ "4" (str.++ "0" ""))))(re.union (str.to_re (str.++ "2" (str.++ "4" (str.++ "8" ""))))(re.union (str.to_re (str.++ "2" (str.++ "5" (str.++ "2" "")))) (str.to_re (str.++ "2" (str.++ "5" (str.++ "4" "")))))))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.range "0" "0")(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (re.range "0" "0")))))))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" (str.++ "5" ""))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (str.to_re (str.++ "2" (str.++ "5" (str.++ "5" ""))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.union (re.range "0" "0")(re.union (str.to_re (str.++ "1" (str.++ "2" (str.++ "8" ""))))(re.union (str.to_re (str.++ "1" (str.++ "9" (str.++ "2" ""))))(re.union (str.to_re (str.++ "2" (str.++ "2" (str.++ "4" ""))))(re.union (str.to_re (str.++ "2" (str.++ "4" (str.++ "0" ""))))(re.union (str.to_re (str.++ "2" (str.++ "4" (str.++ "8" ""))))(re.union (str.to_re (str.++ "2" (str.++ "5" (str.++ "2" "")))) (str.to_re (str.++ "2" (str.++ "5" (str.++ "4" "")))))))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (re.range "0" "0"))))))) (re.++ (str.to_re (str.++ "2" (str.++ "5" (str.++ "5" ""))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (str.to_re (str.++ "2" (str.++ "5" (str.++ "5" ""))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (str.to_re (str.++ "2" (str.++ "5" (str.++ "5" ""))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (re.union (re.range "0" "0")(re.union (str.to_re (str.++ "1" (str.++ "2" (str.++ "8" ""))))(re.union (str.to_re (str.++ "1" (str.++ "9" (str.++ "2" ""))))(re.union (str.to_re (str.++ "2" (str.++ "2" (str.++ "4" ""))))(re.union (str.to_re (str.++ "2" (str.++ "4" (str.++ "0" ""))))(re.union (str.to_re (str.++ "2" (str.++ "4" (str.++ "8" ""))))(re.union (str.to_re (str.++ "2" (str.++ "5" (str.++ "2" "")))) (str.to_re (str.++ "2" (str.++ "5" (str.++ "4" "")))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
