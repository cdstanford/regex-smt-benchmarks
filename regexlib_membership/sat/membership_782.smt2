;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (INSERT INTO\s+)(\w+)(\s+\()([\w+,?\s*]+)(\)\s+VALUES\s+)((\(['?\w+'?,?\s*]+\)\,?;?\s*)+)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(INSERT INTO\u00A0\u0085\u00CD\u00A0(\u00F6\u00C6) VALUES\xA(\u00E8);\u0085\u00DE"
(define-fun Witness1 () String (str.++ "(" (str.++ "I" (str.++ "N" (str.++ "S" (str.++ "E" (str.++ "R" (str.++ "T" (str.++ " " (str.++ "I" (str.++ "N" (str.++ "T" (str.++ "O" (str.++ "\u{a0}" (str.++ "\u{85}" (str.++ "\u{cd}" (str.++ "\u{a0}" (str.++ "(" (str.++ "\u{f6}" (str.++ "\u{c6}" (str.++ ")" (str.++ " " (str.++ "V" (str.++ "A" (str.++ "L" (str.++ "U" (str.++ "E" (str.++ "S" (str.++ "\u{0a}" (str.++ "(" (str.++ "\u{e8}" (str.++ ")" (str.++ ";" (str.++ "\u{85}" (str.++ "\u{de}" "")))))))))))))))))))))))))))))))))))
;witness2: "\u00E2INSERT INTO\u00A0_j1\u00AA\u00CE88\u0085\u0085\u00A0(\u0085)\u00A0\u00A0\xDVALUES (\u00EA\u00C6);(\u0085A\u00FD),;\u00EC"
(define-fun Witness2 () String (str.++ "\u{e2}" (str.++ "I" (str.++ "N" (str.++ "S" (str.++ "E" (str.++ "R" (str.++ "T" (str.++ " " (str.++ "I" (str.++ "N" (str.++ "T" (str.++ "O" (str.++ "\u{a0}" (str.++ "_" (str.++ "j" (str.++ "1" (str.++ "\u{aa}" (str.++ "\u{ce}" (str.++ "8" (str.++ "8" (str.++ "\u{85}" (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ "(" (str.++ "\u{85}" (str.++ ")" (str.++ "\u{a0}" (str.++ "\u{a0}" (str.++ "\u{0d}" (str.++ "V" (str.++ "A" (str.++ "L" (str.++ "U" (str.++ "E" (str.++ "S" (str.++ " " (str.++ "(" (str.++ "\u{ea}" (str.++ "\u{c6}" (str.++ ")" (str.++ ";" (str.++ "(" (str.++ "\u{85}" (str.++ "A" (str.++ "\u{fd}" (str.++ ")" (str.++ "," (str.++ ";" (str.++ "\u{ec}" ""))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.++ (str.to_re (str.++ "I" (str.++ "N" (str.++ "S" (str.++ "E" (str.++ "R" (str.++ "T" (str.++ " " (str.++ "I" (str.++ "N" (str.++ "T" (str.++ "O" "")))))))))))) (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.range "(" "("))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "*" ",")(re.union (re.range "0" "9")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}")(re.union (re.range "\u{a0}" "\u{a0}")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))(re.++ (re.++ (re.range ")" ")")(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (str.to_re (str.++ "V" (str.++ "A" (str.++ "L" (str.++ "U" (str.++ "E" (str.++ "S" ""))))))) (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))) (re.+ (re.++ (re.range "(" "(")(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "'" "'")(re.union (re.range "*" ",")(re.union (re.range "0" "9")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}")(re.union (re.range "\u{a0}" "\u{a0}")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))))))(re.++ (re.range ")" ")")(re.++ (re.opt (re.range "," ","))(re.++ (re.opt (re.range ";" ";")) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
