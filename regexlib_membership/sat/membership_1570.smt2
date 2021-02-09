;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(Function|Sub)(\s+[\w]+)\([^\(\)]*\)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Function \xCn()"
(define-fun Witness1 () String (seq.++ "F" (seq.++ "u" (seq.++ "n" (seq.++ "c" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ " " (seq.++ "\x0c" (seq.++ "n" (seq.++ "(" (seq.++ ")" ""))))))))))))))
;witness2: "Sub\u00A0 \u00D8(\)\u0081XM\u00E3\u008B\u00F9i\u00C9>tS\u0092c\xA"
(define-fun Witness2 () String (seq.++ "S" (seq.++ "u" (seq.++ "b" (seq.++ "\xa0" (seq.++ " " (seq.++ "\xd8" (seq.++ "(" (seq.++ "\x5c" (seq.++ ")" (seq.++ "\x81" (seq.++ "X" (seq.++ "M" (seq.++ "\xe3" (seq.++ "\x8b" (seq.++ "\xf9" (seq.++ "i" (seq.++ "\xc9" (seq.++ ">" (seq.++ "t" (seq.++ "S" (seq.++ "\x92" (seq.++ "c" (seq.++ "\x0a" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (seq.++ "F" (seq.++ "u" (seq.++ "n" (seq.++ "c" (seq.++ "t" (seq.++ "i" (seq.++ "o" (seq.++ "n" ""))))))))) (str.to_re (seq.++ "S" (seq.++ "u" (seq.++ "b" "")))))(re.++ (re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.range "(" "(")(re.++ (re.* (re.union (re.range "\x00" "'") (re.range "*" "\xff"))) (re.range ")" ")"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
