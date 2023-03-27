;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*([\(]?)\[?\s*\d{3}\s*\]?[\)]?\s*[\-]?[\.]?\s*\d{3}\s*[\-]?[\.]?\s*\d{4}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\xD\u00A0\u0085(989]. 868\xA  -9213"
(define-fun Witness1 () String (str.++ "\u{0d}" (str.++ "\u{a0}" (str.++ "\u{85}" (str.++ "(" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "]" (str.++ "." (str.++ " " (str.++ "8" (str.++ "6" (str.++ "8" (str.++ "\u{0a}" (str.++ " " (str.++ " " (str.++ "-" (str.++ "9" (str.++ "2" (str.++ "1" (str.++ "3" ""))))))))))))))))))))))
;witness2: "([ \u00A0\xB\u0085 694]\u00A0  .4812997"
(define-fun Witness2 () String (str.++ "(" (str.++ "[" (str.++ " " (str.++ "\u{a0}" (str.++ "\u{0b}" (str.++ "\u{85}" (str.++ " " (str.++ "6" (str.++ "9" (str.++ "4" (str.++ "]" (str.++ "\u{a0}" (str.++ " " (str.++ " " (str.++ "." (str.++ "4" (str.++ "8" (str.++ "1" (str.++ "2" (str.++ "9" (str.++ "9" (str.++ "7" "")))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "(" "("))(re.++ (re.opt (re.range "[" "["))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "]" "]"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
