;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\s*\(?0\d{4}\)?\s*\d{6}\s*)|(\s*\(?0\d{3}\)?\s*\d{3}\s*\d{4}\s*)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00EE06688)\x9828988\xD"
(define-fun Witness1 () String (str.++ "\u{ee}" (str.++ "0" (str.++ "6" (str.++ "6" (str.++ "8" (str.++ "8" (str.++ ")" (str.++ "\u{09}" (str.++ "8" (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "\u{0d}" ""))))))))))))))))
;witness2: "\u00AB#|\u0085(0989\u0085889\u00A02399\xD\u00B7\u00F0F\xA"
(define-fun Witness2 () String (str.++ "\u{ab}" (str.++ "#" (str.++ "|" (str.++ "\u{85}" (str.++ "(" (str.++ "0" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "\u{85}" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "\u{a0}" (str.++ "2" (str.++ "3" (str.++ "9" (str.++ "9" (str.++ "\u{0d}" (str.++ "\u{b7}" (str.++ "\u{f0}" (str.++ "F" (str.++ "\u{0a}" ""))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))))) (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
