;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<1>.*[\\/])(?<2>.+)\.(?<3>.+)?$|^(?<1>.*[\\/])(?<2>.+)$|^(?<2>.+)\.(?<3>.+)?$|^(?<2>.+)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00D4.\u00CD"
(define-fun Witness1 () String (str.++ "\u{d4}" (str.++ "." (str.++ "\u{cd}" ""))))
;witness2: "\H\x2\u00DC.\u007F"
(define-fun Witness2 () String (str.++ "\u{5c}" (str.++ "H" (str.++ "\u{02}" (str.++ "\u{dc}" (str.++ "." (str.++ "\u{7f}" "")))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.union (re.range "/" "/") (re.range "\u{5c}" "\u{5c}")))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "." ".")(re.++ (re.opt (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.union (re.range "/" "/") (re.range "\u{5c}" "\u{5c}")))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re ""))))(re.union (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "." ".")(re.++ (re.opt (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))) (str.to_re ""))))) (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
