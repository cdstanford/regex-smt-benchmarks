;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:(?:(?:\+)?1[\-\s\.])?(?:\s?\()?(?:[2-9][0-8][0-9])(?:\))?(?:[\s|\-|\.])?)(?:(?:(?:[2-9][0-9|A-Z][0-9|A-Z])(?:[\s|\-|\.])?)(?:[0-9|A-Z][0-9|A-Z][0-9|A-Z][0-9|A-Z]))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00A0\u00AE\u00E0\x21.569)8|||4|6\u0094"
(define-fun Witness1 () String (str.++ "\u{a0}" (str.++ "\u{ae}" (str.++ "\u{e0}" (str.++ "\u{02}" (str.++ "1" (str.++ "." (str.++ "5" (str.++ "6" (str.++ "9" (str.++ ")" (str.++ "8" (str.++ "|" (str.++ "|" (str.++ "|" (str.++ "4" (str.++ "|" (str.++ "6" (str.++ "\u{94}" "")))))))))))))))))))
;witness2: "\u0090\x19\u00A6887\xC6|DN|8Q"
(define-fun Witness2 () String (str.++ "\u{90}" (str.++ "\u{19}" (str.++ "\u{a6}" (str.++ "8" (str.++ "8" (str.++ "7" (str.++ "\u{0c}" (str.++ "6" (str.++ "|" (str.++ "D" (str.++ "N" (str.++ "|" (str.++ "8" (str.++ "Q" "")))))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.opt (re.range "+" "+"))(re.++ (re.range "1" "1") (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))(re.++ (re.opt (re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.range "(" "(")))(re.++ (re.range "2" "9")(re.++ (re.range "0" "8")(re.++ (re.range "0" "9")(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "|" "|")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))(re.++ (re.range "2" "9")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "|" "|")))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "|" "|")))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "|" "|")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "|" "|")))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "|" "|")))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "|" "|"))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "|" "|")))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
