;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (UPDATE\s+)(\w+)\s+(SET)\s+([\w+\s*=\s*\w+,?\s*]+)\s+(WHERE.+)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u009DUPDATE\u0085\u00AA\u0085\xD\u0085 \u00A0\xBSET\u00A0ChR\u00AA\u0085\u0085 WHERE\u00C2"
(define-fun Witness1 () String (seq.++ "\x9d" (seq.++ "U" (seq.++ "P" (seq.++ "D" (seq.++ "A" (seq.++ "T" (seq.++ "E" (seq.++ "\x85" (seq.++ "\xaa" (seq.++ "\x85" (seq.++ "\x0d" (seq.++ "\x85" (seq.++ " " (seq.++ "\xa0" (seq.++ "\x0b" (seq.++ "S" (seq.++ "E" (seq.++ "T" (seq.++ "\xa0" (seq.++ "C" (seq.++ "h" (seq.++ "R" (seq.++ "\xaa" (seq.++ "\x85" (seq.++ "\x85" (seq.++ " " (seq.++ "W" (seq.++ "H" (seq.++ "E" (seq.++ "R" (seq.++ "E" (seq.++ "\xc2" "")))))))))))))))))))))))))))))))))
;witness2: "\x15\u00C5\x1F\u008CUPDATE\xA\u00D4\u00AA\u00A0\u00A0\u0085SET G\u00A0\u0085WHERE\u00AC\u00D0"
(define-fun Witness2 () String (seq.++ "\x15" (seq.++ "\xc5" (seq.++ "\x1f" (seq.++ "\x8c" (seq.++ "U" (seq.++ "P" (seq.++ "D" (seq.++ "A" (seq.++ "T" (seq.++ "E" (seq.++ "\x0a" (seq.++ "\xd4" (seq.++ "\xaa" (seq.++ "\xa0" (seq.++ "\xa0" (seq.++ "\x85" (seq.++ "S" (seq.++ "E" (seq.++ "T" (seq.++ " " (seq.++ "G" (seq.++ "\xa0" (seq.++ "\x85" (seq.++ "W" (seq.++ "H" (seq.++ "E" (seq.++ "R" (seq.++ "E" (seq.++ "\xac" (seq.++ "\xd0" "")))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.++ (str.to_re (seq.++ "U" (seq.++ "P" (seq.++ "D" (seq.++ "A" (seq.++ "T" (seq.++ "E" ""))))))) (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (str.to_re (seq.++ "S" (seq.++ "E" (seq.++ "T" ""))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "*" ",")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85")(re.union (re.range "\xa0" "\xa0")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.++ (str.to_re (seq.++ "W" (seq.++ "H" (seq.++ "E" (seq.++ "R" (seq.++ "E" "")))))) (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
