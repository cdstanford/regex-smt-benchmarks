;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<title>.*\.\s)*(?<firstname>([A-Z][a-z]+\s*)+)(\s)(?<middleinitial>([A-Z]\.?\s)*)(?<lastname>[A-Z][a-zA-Z-']+)(?<suffix>.*)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ".\u0085\u00ABg.\u00A0Ng X\xDG.\u00A0L\xCNNw\u00CF\xB"
(define-fun Witness1 () String (str.++ "." (str.++ "\u{85}" (str.++ "\u{ab}" (str.++ "g" (str.++ "." (str.++ "\u{a0}" (str.++ "N" (str.++ "g" (str.++ " " (str.++ "X" (str.++ "\u{0d}" (str.++ "G" (str.++ "." (str.++ "\u{a0}" (str.++ "L" (str.++ "\u{0c}" (str.++ "N" (str.++ "N" (str.++ "w" (str.++ "\u{cf}" (str.++ "\u{0b}" ""))))))))))))))))))))))
;witness2: "Yuit\u0085\u00A0Kph\u0085\u00A0Z.\u00A0V-z\'\u00B8"
(define-fun Witness2 () String (str.++ "Y" (str.++ "u" (str.++ "i" (str.++ "t" (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ "K" (str.++ "p" (str.++ "h" (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ "Z" (str.++ "." (str.++ "\u{a0}" (str.++ "V" (str.++ "-" (str.++ "z" (str.++ "'" (str.++ "\u{b8}" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "." ".") (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))(re.++ (re.+ (re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z")) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.* (re.++ (re.range "A" "Z")(re.++ (re.opt (re.range "." ".")) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))(re.++ (re.++ (re.range "A" "Z") (re.+ (re.union (re.range "'" "'")(re.union (re.range "-" "-")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
