;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (02\d\s?\d{4}\s?\d{4})|(01\d{2}\s?\d{3}\s?\d{4})|(01\d{3}\s?\d{5,6})|(01\d{4}\s?\d{4,5})
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00F6O\u00B901899859800"
(define-fun Witness1 () String (str.++ "\u{f6}" (str.++ "O" (str.++ "\u{b9}" (str.++ "0" (str.++ "1" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "5" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "0" "")))))))))))))))
;witness2: "019839\u00A089872"
(define-fun Witness2 () String (str.++ "0" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "3" (str.++ "9" (str.++ "\u{a0}" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "7" (str.++ "2" "")))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (str.++ "0" (str.++ "2" "")))(re.++ (re.range "0" "9")(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 4 4) (re.range "0" "9")))))))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "1" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 4 4) (re.range "0" "9")))))))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "1" "")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 5 6) (re.range "0" "9"))))) (re.++ (str.to_re (str.++ "0" (str.++ "1" "")))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 4 5) (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
