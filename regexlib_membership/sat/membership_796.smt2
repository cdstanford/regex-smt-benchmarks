;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \(?(\d{3})(?:\)*|\)\s*-*|\.*|\s*|/*|)(\d{3})(?:\)*|-*|\.*|\s*|/*|)(\d{4})(?:\s?|,\s?)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(2890895499\u0085*n"
(define-fun Witness1 () String (str.++ "(" (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "0" (str.++ "8" (str.++ "9" (str.++ "5" (str.++ "4" (str.++ "9" (str.++ "9" (str.++ "\u{85}" (str.++ "*" (str.++ "n" "")))))))))))))))
;witness2: "(138/0467832 \u00EB"
(define-fun Witness2 () String (str.++ "(" (str.++ "1" (str.++ "3" (str.++ "8" (str.++ "/" (str.++ "0" (str.++ "4" (str.++ "6" (str.++ "7" (str.++ "8" (str.++ "3" (str.++ "2" (str.++ " " (str.++ "\u{eb}" "")))))))))))))))

(assert (= regexA (re.++ (re.opt (re.range "(" "("))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.* (re.range ")" ")"))(re.union (re.++ (re.range ")" ")")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.* (re.range "-" "-"))))(re.union (re.* (re.range "." "."))(re.union (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.union (re.* (re.range "/" "/")) (str.to_re ""))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.* (re.range ")" ")"))(re.union (re.* (re.range "-" "-"))(re.union (re.* (re.range "." "."))(re.union (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.union (re.* (re.range "/" "/")) (str.to_re ""))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.union (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.++ (re.range "," ",") (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
