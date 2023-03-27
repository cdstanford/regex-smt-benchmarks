;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (INSERT INTO\s+)(\w+)(\s+\()([\w+,?\s*]+)(\)\s+VALUES\s+\()(['?\w+'?,?\s*]+)(\))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "VINSERT INTO  \xD\u00F8\u0085(\xCy\x9)\u00A0VALUES\xB\xB  (\u00DD\u00F2)"
(define-fun Witness1 () String (str.++ "V" (str.++ "I" (str.++ "N" (str.++ "S" (str.++ "E" (str.++ "R" (str.++ "T" (str.++ " " (str.++ "I" (str.++ "N" (str.++ "T" (str.++ "O" (str.++ " " (str.++ " " (str.++ "\u{0d}" (str.++ "\u{f8}" (str.++ "\u{85}" (str.++ "(" (str.++ "\u{0c}" (str.++ "y" (str.++ "\u{09}" (str.++ ")" (str.++ "\u{a0}" (str.++ "V" (str.++ "A" (str.++ "L" (str.++ "U" (str.++ "E" (str.++ "S" (str.++ "\u{0b}" (str.++ "\u{0b}" (str.++ " " (str.++ " " (str.++ "(" (str.++ "\u{dd}" (str.++ "\u{f2}" (str.++ ")" ""))))))))))))))))))))))))))))))))))))))
;witness2: "INSERT INTO\u00A0\u00AA\u00BA (\xCZ)\u0085\u00A0 VALUES\u00A0\u0085\xD \x9(8)\u00EFZA\u0088\u00D5"
(define-fun Witness2 () String (str.++ "I" (str.++ "N" (str.++ "S" (str.++ "E" (str.++ "R" (str.++ "T" (str.++ " " (str.++ "I" (str.++ "N" (str.++ "T" (str.++ "O" (str.++ "\u{a0}" (str.++ "\u{aa}" (str.++ "\u{ba}" (str.++ " " (str.++ "(" (str.++ "\u{0c}" (str.++ "Z" (str.++ ")" (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ " " (str.++ "V" (str.++ "A" (str.++ "L" (str.++ "U" (str.++ "E" (str.++ "S" (str.++ "\u{a0}" (str.++ "\u{85}" (str.++ "\u{0d}" (str.++ " " (str.++ "\u{09}" (str.++ "(" (str.++ "8" (str.++ ")" (str.++ "\u{ef}" (str.++ "Z" (str.++ "A" (str.++ "\u{88}" (str.++ "\u{d5}" ""))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.++ (str.to_re (str.++ "I" (str.++ "N" (str.++ "S" (str.++ "E" (str.++ "R" (str.++ "T" (str.++ " " (str.++ "I" (str.++ "N" (str.++ "T" (str.++ "O" "")))))))))))) (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.range "(" "("))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "*" ",")(re.union (re.range "0" "9")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}")(re.union (re.range "\u{a0}" "\u{a0}")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))(re.++ (re.++ (re.range ")" ")")(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (str.to_re (str.++ "V" (str.++ "A" (str.++ "L" (str.++ "U" (str.++ "E" (str.++ "S" "")))))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.range "(" "(")))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "'" "'")(re.union (re.range "*" ",")(re.union (re.range "0" "9")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}")(re.union (re.range "\u{a0}" "\u{a0}")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))) (re.range ")" ")")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
