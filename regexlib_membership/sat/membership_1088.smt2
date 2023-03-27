;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((67\d{2})|(4\d{3})|(5[1-5]\d{2})|(6011))(-?\s?\d{4}){3}|(3[4,7])\d{2}-?\s?\d{6}-?\s?\d{5}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00CD3758-\u008549314900814"
(define-fun Witness1 () String (str.++ "\u{cd}" (str.++ "3" (str.++ "7" (str.++ "5" (str.++ "8" (str.++ "-" (str.++ "\u{85}" (str.++ "4" (str.++ "9" (str.++ "3" (str.++ "1" (str.++ "4" (str.++ "9" (str.++ "0" (str.++ "0" (str.++ "8" (str.++ "1" (str.++ "4" "")))))))))))))))))))
;witness2: "3,88-989980-88188"
(define-fun Witness2 () String (str.++ "3" (str.++ "," (str.++ "8" (str.++ "8" (str.++ "-" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "-" (str.++ "8" (str.++ "8" (str.++ "1" (str.++ "8" (str.++ "8" ""))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (str.++ "6" (str.++ "7" ""))) ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "4" "4") ((_ re.loop 3 3) (re.range "0" "9")))(re.union (re.++ (re.range "5" "5")(re.++ (re.range "1" "5") ((_ re.loop 2 2) (re.range "0" "9")))) (str.to_re (str.++ "6" (str.++ "0" (str.++ "1" (str.++ "1" "")))))))) ((_ re.loop 3 3) (re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 4 4) (re.range "0" "9"))))))) (re.++ (re.++ (re.range "3" "3") (re.union (re.range "," ",")(re.union (re.range "4" "4") (re.range "7" "7"))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 5 5) (re.range "0" "9")) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
