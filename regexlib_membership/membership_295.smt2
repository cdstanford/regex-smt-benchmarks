;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [\+]?[\s]?(\d(\-|\s)?)?(\(\d{3}\)\s?|\d{3}\-?)\d{3}(-|\s-\s)?\d{4}(\s(ex|ext)\s?\d+)?
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+ 9(709)\u0085190-8988\u00A0ext 58\xF6"
(define-fun Witness1 () String (str.++ "+" (str.++ " " (str.++ "9" (str.++ "(" (str.++ "7" (str.++ "0" (str.++ "9" (str.++ ")" (str.++ "\u{85}" (str.++ "1" (str.++ "9" (str.++ "0" (str.++ "-" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "\u{a0}" (str.++ "e" (str.++ "x" (str.++ "t" (str.++ " " (str.++ "5" (str.++ "8" (str.++ "\u{0f}" (str.++ "6" "")))))))))))))))))))))))))))
;witness2: "f\u00B6+\x946898940937="
(define-fun Witness2 () String (str.++ "f" (str.++ "\u{b6}" (str.++ "+" (str.++ "\u{09}" (str.++ "4" (str.++ "6" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "4" (str.++ "0" (str.++ "9" (str.++ "3" (str.++ "7" (str.++ "=" "")))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.range "+" "+"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.++ (re.range "0" "9") (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))(re.++ (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range ")" ")") (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))) (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range "-" "-"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "-" "-") (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.range "-" "-") (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.opt (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.union (str.to_re (str.++ "e" (str.++ "x" ""))) (str.to_re (str.++ "e" (str.++ "x" (str.++ "t" "")))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.+ (re.range "0" "9")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
