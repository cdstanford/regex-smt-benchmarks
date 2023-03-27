;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((\+?64\s*[-\.]?[3-9]|\(?0[3-9]\)?)\s*[-\.]?\d{3}\s*[-\.]?\d{4})|((\+?64\s*[-\.\(]?2\d{1}[-\.\)]?|\(?02\d{1}\)?)\s*[-\.]?\d{3}\s*[-\.]?\d{3,5})|((\+?64\s*[-\.]?[-\.\(]?800[-\.\)]?|[-\.\(]?0800[-\.\)]?)\s*[-\.]?\d{3}\s*[-\.]?(\d{2}|\d{5})))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+64(800) 57639"
(define-fun Witness1 () String (str.++ "+" (str.++ "6" (str.++ "4" (str.++ "(" (str.++ "8" (str.++ "0" (str.++ "0" (str.++ ")" (str.++ " " (str.++ "5" (str.++ "7" (str.++ "6" (str.++ "3" (str.++ "9" "")))))))))))))))
;witness2: "64\u00A0\x9800.98419859"
(define-fun Witness2 () String (str.++ "6" (str.++ "4" (str.++ "\u{a0}" (str.++ "\u{09}" (str.++ "8" (str.++ "0" (str.++ "0" (str.++ "." (str.++ "9" (str.++ "8" (str.++ "4" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "5" (str.++ "9" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.opt (re.range "+" "+"))(re.++ (str.to_re (str.++ "6" (str.++ "4" "")))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" ".")) (re.range "3" "9"))))) (re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ (re.range "3" "9") (re.opt (re.range ")" ")"))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "."))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" ".")) ((_ re.loop 4 4) (re.range "0" "9"))))))))(re.union (re.++ (re.union (re.++ (re.opt (re.range "+" "+"))(re.++ (str.to_re (str.++ "6" (str.++ "4" "")))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.union (re.range "(" "(") (re.range "-" ".")))(re.++ (re.range "2" "2")(re.++ (re.range "0" "9") (re.opt (re.union (re.range ")" ")") (re.range "-" "."))))))))) (re.++ (re.opt (re.range "(" "("))(re.++ (str.to_re (str.++ "0" (str.++ "2" "")))(re.++ (re.range "0" "9") (re.opt (re.range ")" ")"))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "."))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" ".")) ((_ re.loop 3 5) (re.range "0" "9")))))))) (re.++ (re.union (re.++ (re.opt (re.range "+" "+"))(re.++ (str.to_re (str.++ "6" (str.++ "4" "")))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "."))(re.++ (re.opt (re.union (re.range "(" "(") (re.range "-" ".")))(re.++ (str.to_re (str.++ "8" (str.++ "0" (str.++ "0" "")))) (re.opt (re.union (re.range ")" ")") (re.range "-" "."))))))))) (re.++ (re.opt (re.union (re.range "(" "(") (re.range "-" ".")))(re.++ (str.to_re (str.++ "0" (str.++ "8" (str.++ "0" (str.++ "0" ""))))) (re.opt (re.union (re.range ")" ")") (re.range "-" "."))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "."))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" ".")) (re.union ((_ re.loop 2 2) (re.range "0" "9")) ((_ re.loop 5 5) (re.range "0" "9"))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
