;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \[(?<GroupName>.*)\](?<GroupContent>[^\[]+)       --------        [\s]*(?<Key>.+)[\s]*=[\s]*(?<Value>[^\r]+) 
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "[]a       --------        \u00B0\x9=\u00DF \u0092\u00F4"
(define-fun Witness1 () String (str.++ "[" (str.++ "]" (str.++ "a" (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ "\u{b0}" (str.++ "\u{09}" (str.++ "=" (str.++ "\u{df}" (str.++ " " (str.++ "\u{92}" (str.++ "\u{f4}" ""))))))))))))))))))))))))))))))))))
;witness2: "[]%U       --------        \u0085\xD\x9\xD\u00F8Y\u008F=\u0085 \u00A3 7\u00CE"
(define-fun Witness2 () String (str.++ "[" (str.++ "]" (str.++ "%" (str.++ "U" (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ "\u{85}" (str.++ "\u{0d}" (str.++ "\u{09}" (str.++ "\u{0d}" (str.++ "\u{f8}" (str.++ "Y" (str.++ "\u{8f}" (str.++ "=" (str.++ "\u{85}" (str.++ " " (str.++ "\u{a3}" (str.++ " " (str.++ "7" (str.++ "\u{ce}" ""))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.range "[" "[")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "]" "]")(re.++ (re.+ (re.union (re.range "\u{00}" "Z") (re.range "\u{5c}" "\u{ff}")))(re.++ (str.to_re (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " ""))))))))))))))))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{0c}") (re.range "\u{0e}" "\u{ff}"))) (re.range " " " "))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
