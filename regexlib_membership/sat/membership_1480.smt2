;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (<meta\s+)*((name\s*=\s*("|')(?<name>[^'("|')]*)("|')){1}|content\s*=\s*("|')(?<content>[^'("|')]*)("|')|scheme\s*=\s*("|')(?<scheme>[^'("|')]*)("|'))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "content\u0085=  \x9\u0085\u00A0\xB\xA\x9\'\"\u00B20\x1D\u00DCQ"
(define-fun Witness1 () String (str.++ "c" (str.++ "o" (str.++ "n" (str.++ "t" (str.++ "e" (str.++ "n" (str.++ "t" (str.++ "\u{85}" (str.++ "=" (str.++ " " (str.++ " " (str.++ "\u{09}" (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ "\u{0b}" (str.++ "\u{0a}" (str.++ "\u{09}" (str.++ "'" (str.++ "\u{22}" (str.++ "\u{b2}" (str.++ "0" (str.++ "\u{1d}" (str.++ "\u{dc}" (str.++ "Q" "")))))))))))))))))))))))))
;witness2: "&\u00A4<meta\u0085name\u0085= \u0085\'\u00A3\"\u00FA"
(define-fun Witness2 () String (str.++ "&" (str.++ "\u{a4}" (str.++ "<" (str.++ "m" (str.++ "e" (str.++ "t" (str.++ "a" (str.++ "\u{85}" (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" (str.++ "\u{85}" (str.++ "=" (str.++ " " (str.++ "\u{85}" (str.++ "'" (str.++ "\u{a3}" (str.++ "\u{22}" (str.++ "\u{fa}" "")))))))))))))))))))))

(assert (= regexA (re.++ (re.* (re.++ (str.to_re (str.++ "<" (str.++ "m" (str.++ "e" (str.++ "t" (str.++ "a" "")))))) (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))) (re.union (re.++ (str.to_re (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" "")))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.range "\u{22}" "\u{22}") (re.range "'" "'"))(re.++ (re.* (re.union (re.range "\u{00}" "!")(re.union (re.range "#" "&")(re.union (re.range "*" "{") (re.range "}" "\u{ff}"))))) (re.union (re.range "\u{22}" "\u{22}") (re.range "'" "'"))))))))(re.union (re.++ (str.to_re (str.++ "c" (str.++ "o" (str.++ "n" (str.++ "t" (str.++ "e" (str.++ "n" (str.++ "t" ""))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.range "\u{22}" "\u{22}") (re.range "'" "'"))(re.++ (re.* (re.union (re.range "\u{00}" "!")(re.union (re.range "#" "&")(re.union (re.range "*" "{") (re.range "}" "\u{ff}"))))) (re.union (re.range "\u{22}" "\u{22}") (re.range "'" "'")))))))) (re.++ (str.to_re (str.++ "s" (str.++ "c" (str.++ "h" (str.++ "e" (str.++ "m" (str.++ "e" "")))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.range "\u{22}" "\u{22}") (re.range "'" "'"))(re.++ (re.* (re.union (re.range "\u{00}" "!")(re.union (re.range "#" "&")(re.union (re.range "*" "{") (re.range "}" "\u{ff}"))))) (re.union (re.range "\u{22}" "\u{22}") (re.range "'" "'")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
