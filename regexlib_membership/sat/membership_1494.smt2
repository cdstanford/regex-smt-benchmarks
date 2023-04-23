;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+44\s?7\d{3}|\(?07\d{3}\)?)\s?\d{3}\s?\d{3}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(07889\u0085499996"
(define-fun Witness1 () String (str.++ "(" (str.++ "0" (str.++ "7" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "\u{85}" (str.++ "4" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "6" ""))))))))))))))
;witness2: "(07298)819049"
(define-fun Witness2 () String (str.++ "(" (str.++ "0" (str.++ "7" (str.++ "2" (str.++ "9" (str.++ "8" (str.++ ")" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "0" (str.++ "4" (str.++ "9" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (str.++ "+" (str.++ "4" (str.++ "4" ""))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "7" "7") ((_ re.loop 3 3) (re.range "0" "9"))))) (re.++ (re.opt (re.range "(" "("))(re.++ (str.to_re (str.++ "0" (str.++ "7" "")))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range ")" ")"))))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
