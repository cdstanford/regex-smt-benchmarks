;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (INSERT INTO\s+)(\w+)(\s+\()([\w+,?\s*]+)(\)\s+VALUES\s+)((\(['?\w+'?,?\s*]+\)\,?;?\s*)+)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(INSERT INTO\u00A0\u0085\u00CD\u00A0(\u00F6\u00C6) VALUES\xA(\u00E8);\u0085\u00DE"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "I" (seq.++ "N" (seq.++ "S" (seq.++ "E" (seq.++ "R" (seq.++ "T" (seq.++ " " (seq.++ "I" (seq.++ "N" (seq.++ "T" (seq.++ "O" (seq.++ "\xa0" (seq.++ "\x85" (seq.++ "\xcd" (seq.++ "\xa0" (seq.++ "(" (seq.++ "\xf6" (seq.++ "\xc6" (seq.++ ")" (seq.++ " " (seq.++ "V" (seq.++ "A" (seq.++ "L" (seq.++ "U" (seq.++ "E" (seq.++ "S" (seq.++ "\x0a" (seq.++ "(" (seq.++ "\xe8" (seq.++ ")" (seq.++ ";" (seq.++ "\x85" (seq.++ "\xde" "")))))))))))))))))))))))))))))))))))
;witness2: "\u00E2INSERT INTO\u00A0_j1\u00AA\u00CE88\u0085\u0085\u00A0(\u0085)\u00A0\u00A0\xDVALUES (\u00EA\u00C6);(\u0085A\u00FD),;\u00EC"
(define-fun Witness2 () String (seq.++ "\xe2" (seq.++ "I" (seq.++ "N" (seq.++ "S" (seq.++ "E" (seq.++ "R" (seq.++ "T" (seq.++ " " (seq.++ "I" (seq.++ "N" (seq.++ "T" (seq.++ "O" (seq.++ "\xa0" (seq.++ "_" (seq.++ "j" (seq.++ "1" (seq.++ "\xaa" (seq.++ "\xce" (seq.++ "8" (seq.++ "8" (seq.++ "\x85" (seq.++ "\x85" (seq.++ "\xa0" (seq.++ "(" (seq.++ "\x85" (seq.++ ")" (seq.++ "\xa0" (seq.++ "\xa0" (seq.++ "\x0d" (seq.++ "V" (seq.++ "A" (seq.++ "L" (seq.++ "U" (seq.++ "E" (seq.++ "S" (seq.++ " " (seq.++ "(" (seq.++ "\xea" (seq.++ "\xc6" (seq.++ ")" (seq.++ ";" (seq.++ "(" (seq.++ "\x85" (seq.++ "A" (seq.++ "\xfd" (seq.++ ")" (seq.++ "," (seq.++ ";" (seq.++ "\xec" ""))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.++ (str.to_re (seq.++ "I" (seq.++ "N" (seq.++ "S" (seq.++ "E" (seq.++ "R" (seq.++ "T" (seq.++ " " (seq.++ "I" (seq.++ "N" (seq.++ "T" (seq.++ "O" "")))))))))))) (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.range "(" "("))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "*" ",")(re.union (re.range "0" "9")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85")(re.union (re.range "\xa0" "\xa0")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))(re.++ (re.++ (re.range ")" ")")(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (str.to_re (seq.++ "V" (seq.++ "A" (seq.++ "L" (seq.++ "U" (seq.++ "E" (seq.++ "S" ""))))))) (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))) (re.+ (re.++ (re.range "(" "(")(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "'" "'")(re.union (re.range "*" ",")(re.union (re.range "0" "9")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85")(re.union (re.range "\xa0" "\xa0")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))))))(re.++ (re.range ")" ")")(re.++ (re.opt (re.range "," ","))(re.++ (re.opt (re.range ";" ";")) (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
