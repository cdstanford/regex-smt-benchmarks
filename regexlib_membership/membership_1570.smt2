;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(Function|Sub)(\s+[\w]+)\([^\(\)]*\)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Function \xCn()"
(define-fun Witness1 () String (str.++ "F" (str.++ "u" (str.++ "n" (str.++ "c" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ " " (str.++ "\u{0c}" (str.++ "n" (str.++ "(" (str.++ ")" ""))))))))))))))
;witness2: "Sub\u00A0 \u00D8(\)\u0081XM\u00E3\u008B\u00F9i\u00C9>tS\u0092c\xA"
(define-fun Witness2 () String (str.++ "S" (str.++ "u" (str.++ "b" (str.++ "\u{a0}" (str.++ " " (str.++ "\u{d8}" (str.++ "(" (str.++ "\u{5c}" (str.++ ")" (str.++ "\u{81}" (str.++ "X" (str.++ "M" (str.++ "\u{e3}" (str.++ "\u{8b}" (str.++ "\u{f9}" (str.++ "i" (str.++ "\u{c9}" (str.++ ">" (str.++ "t" (str.++ "S" (str.++ "\u{92}" (str.++ "c" (str.++ "\u{0a}" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (str.++ "F" (str.++ "u" (str.++ "n" (str.++ "c" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" ""))))))))) (str.to_re (str.++ "S" (str.++ "u" (str.++ "b" "")))))(re.++ (re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.range "(" "(")(re.++ (re.* (re.union (re.range "\u{00}" "'") (re.range "*" "\u{ff}"))) (re.range ")" ")"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
