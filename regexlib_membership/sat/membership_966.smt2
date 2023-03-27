;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \(?\s*(?<area>\d{3})\s*[\)\.\-]?\s*(?<first>\d{3})\s*[\-\.]?\s*(?<second>\d{4})\D*(?<ext>\d*)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "( 799\u0085)993\x9\u00A0.8919"
(define-fun Witness1 () String (str.++ "(" (str.++ " " (str.++ "7" (str.++ "9" (str.++ "9" (str.++ "\u{85}" (str.++ ")" (str.++ "9" (str.++ "9" (str.++ "3" (str.++ "\u{09}" (str.++ "\u{a0}" (str.++ "." (str.++ "8" (str.++ "9" (str.++ "1" (str.++ "9" ""))))))))))))))))))
;witness2: "\u009B\\u00A7z362\u00A0.868\u00A0\xC\u00A0 .\xD7682X.99\u00AB"
(define-fun Witness2 () String (str.++ "\u{9b}" (str.++ "\u{5c}" (str.++ "\u{a7}" (str.++ "z" (str.++ "3" (str.++ "6" (str.++ "2" (str.++ "\u{a0}" (str.++ "." (str.++ "8" (str.++ "6" (str.++ "8" (str.++ "\u{a0}" (str.++ "\u{0c}" (str.++ "\u{a0}" (str.++ " " (str.++ "." (str.++ "\u{0d}" (str.++ "7" (str.++ "6" (str.++ "8" (str.++ "2" (str.++ "X" (str.++ "." (str.++ "9" (str.++ "9" (str.++ "\u{ab}" ""))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.range "(" "("))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.union (re.range ")" ")") (re.range "-" ".")))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "."))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}"))) (re.* (re.range "0" "9"))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
