;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\s*\(?0\d{4}\)?(\s*|-)\d{3}(\s*|-)\d{3}\s*)|(\s*\(?0\d{3}\)?(\s*|-)\d{3}(\s*|-)\d{4}\s*)|(\s*(7|8)(\d{7}|\d{3}(\-|\s{1})\d{4})\s*)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "e\u00D80968-327-8869"
(define-fun Witness1 () String (str.++ "e" (str.++ "\u{d8}" (str.++ "0" (str.++ "9" (str.++ "6" (str.++ "8" (str.++ "-" (str.++ "3" (str.++ "2" (str.++ "7" (str.++ "-" (str.++ "8" (str.++ "8" (str.++ "6" (str.++ "9" ""))))))))))))))))
;witness2: "\u0085\u0085\xC\u00A0(0097-697-3099\xD\u0085"
(define-fun Witness2 () String (str.++ "\u{85}" (str.++ "\u{85}" (str.++ "\u{0c}" (str.++ "\u{a0}" (str.++ "(" (str.++ "0" (str.++ "0" (str.++ "9" (str.++ "7" (str.++ "-" (str.++ "6" (str.++ "9" (str.++ "7" (str.++ "-" (str.++ "3" (str.++ "0" (str.++ "9" (str.++ "9" (str.++ "\u{0d}" (str.++ "\u{85}" "")))))))))))))))))))))

(assert (= regexA (re.union (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.union (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))))))))(re.union (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.union (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))))))) (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "7" "8")(re.++ (re.union ((_ re.loop 7 7) (re.range "0" "9")) (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 4 4) (re.range "0" "9"))))) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
