;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (INSERT INTO\s+)(\w+)(\s+\()([\w+,?\s*]+)(\)\s+VALUES\s+\()(['?\w+'?,?\s*]+)(\))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "VINSERT INTO  \xD\u00F8\u0085(\xCy\x9)\u00A0VALUES\xB\xB  (\u00DD\u00F2)"
(define-fun Witness1 () String (seq.++ "V" (seq.++ "I" (seq.++ "N" (seq.++ "S" (seq.++ "E" (seq.++ "R" (seq.++ "T" (seq.++ " " (seq.++ "I" (seq.++ "N" (seq.++ "T" (seq.++ "O" (seq.++ " " (seq.++ " " (seq.++ "\x0d" (seq.++ "\xf8" (seq.++ "\x85" (seq.++ "(" (seq.++ "\x0c" (seq.++ "y" (seq.++ "\x09" (seq.++ ")" (seq.++ "\xa0" (seq.++ "V" (seq.++ "A" (seq.++ "L" (seq.++ "U" (seq.++ "E" (seq.++ "S" (seq.++ "\x0b" (seq.++ "\x0b" (seq.++ " " (seq.++ " " (seq.++ "(" (seq.++ "\xdd" (seq.++ "\xf2" (seq.++ ")" ""))))))))))))))))))))))))))))))))))))))
;witness2: "INSERT INTO\u00A0\u00AA\u00BA (\xCZ)\u0085\u00A0 VALUES\u00A0\u0085\xD \x9(8)\u00EFZA\u0088\u00D5"
(define-fun Witness2 () String (seq.++ "I" (seq.++ "N" (seq.++ "S" (seq.++ "E" (seq.++ "R" (seq.++ "T" (seq.++ " " (seq.++ "I" (seq.++ "N" (seq.++ "T" (seq.++ "O" (seq.++ "\xa0" (seq.++ "\xaa" (seq.++ "\xba" (seq.++ " " (seq.++ "(" (seq.++ "\x0c" (seq.++ "Z" (seq.++ ")" (seq.++ "\x85" (seq.++ "\xa0" (seq.++ " " (seq.++ "V" (seq.++ "A" (seq.++ "L" (seq.++ "U" (seq.++ "E" (seq.++ "S" (seq.++ "\xa0" (seq.++ "\x85" (seq.++ "\x0d" (seq.++ " " (seq.++ "\x09" (seq.++ "(" (seq.++ "8" (seq.++ ")" (seq.++ "\xef" (seq.++ "Z" (seq.++ "A" (seq.++ "\x88" (seq.++ "\xd5" ""))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.++ (str.to_re (seq.++ "I" (seq.++ "N" (seq.++ "S" (seq.++ "E" (seq.++ "R" (seq.++ "T" (seq.++ " " (seq.++ "I" (seq.++ "N" (seq.++ "T" (seq.++ "O" "")))))))))))) (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.range "(" "("))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "*" ",")(re.union (re.range "0" "9")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85")(re.union (re.range "\xa0" "\xa0")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))(re.++ (re.++ (re.range ")" ")")(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (str.to_re (seq.++ "V" (seq.++ "A" (seq.++ "L" (seq.++ "U" (seq.++ "E" (seq.++ "S" "")))))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.range "(" "(")))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "'" "'")(re.union (re.range "*" ",")(re.union (re.range "0" "9")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85")(re.union (re.range "\xa0" "\xa0")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))) (re.range ")" ")")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
