;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<CountryCode>[1]?)\s?\(?(?<AreaCode>[2-9]{1}\d{2})\)?\s?(?<Prefix>[0-9]{3})(?:[-]|\s)?(?<Postfix>\d{4})\s?(?:ext|x\s?)(?<Extension>[1-9]{1}\d*)?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1(611\x99756898x "
(define-fun Witness1 () String (str.++ "1" (str.++ "(" (str.++ "6" (str.++ "1" (str.++ "1" (str.++ "\u{09}" (str.++ "9" (str.++ "7" (str.++ "5" (str.++ "6" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "x" (str.++ " " ""))))))))))))))))
;witness2: "\x9989 357\u00852138x\u00A0"
(define-fun Witness2 () String (str.++ "\u{09}" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ " " (str.++ "3" (str.++ "5" (str.++ "7" (str.++ "\u{85}" (str.++ "2" (str.++ "1" (str.++ "3" (str.++ "8" (str.++ "x" (str.++ "\u{a0}" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "1" "1"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "(" "("))(re.++ (re.++ (re.range "2" "9") ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (str.to_re (str.++ "e" (str.++ "x" (str.++ "t" "")))) (re.++ (re.range "x" "x") (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))(re.++ (re.opt (re.++ (re.range "1" "9") (re.* (re.range "0" "9")))) (str.to_re ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
