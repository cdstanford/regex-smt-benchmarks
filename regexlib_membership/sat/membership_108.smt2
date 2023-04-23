;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(02\d\s?\d{4}\s?\d{4})|((01|05)\d{2}\s?\d{3}\s?\d{4})|((01|05)\d{3}\s?\d{5,6})|((01|05)\d{4}\s?\d{4,5})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0269499 8985"
(define-fun Witness1 () String (str.++ "0" (str.++ "2" (str.++ "6" (str.++ "9" (str.++ "4" (str.++ "9" (str.++ "9" (str.++ " " (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "5" "")))))))))))))
;witness2: "\u00BEd\u007F0585\u00A08799087"
(define-fun Witness2 () String (str.++ "\u{be}" (str.++ "d" (str.++ "\u{7f}" (str.++ "0" (str.++ "5" (str.++ "8" (str.++ "5" (str.++ "\u{a0}" (str.++ "8" (str.++ "7" (str.++ "9" (str.++ "9" (str.++ "0" (str.++ "8" (str.++ "7" ""))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ (str.to_re (str.++ "0" (str.++ "2" "")))(re.++ (re.range "0" "9")(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 4 4) (re.range "0" "9"))))))))(re.union (re.++ (re.union (str.to_re (str.++ "0" (str.++ "1" ""))) (str.to_re (str.++ "0" (str.++ "5" ""))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 4 4) (re.range "0" "9")))))))(re.union (re.++ (re.union (str.to_re (str.++ "0" (str.++ "1" ""))) (str.to_re (str.++ "0" (str.++ "5" ""))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 5 6) (re.range "0" "9"))))) (re.++ (re.++ (re.union (str.to_re (str.++ "0" (str.++ "1" ""))) (str.to_re (str.++ "0" (str.++ "5" ""))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 4 5) (re.range "0" "9"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
