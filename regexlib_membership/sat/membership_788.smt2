;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (UPDATE\s+)(\w+)\s+(SET)\s+([\w+\s*=\s*\w+,?\s*]+)\s+(WHERE.+)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u009DUPDATE\u0085\u00AA\u0085\xD\u0085 \u00A0\xBSET\u00A0ChR\u00AA\u0085\u0085 WHERE\u00C2"
(define-fun Witness1 () String (str.++ "\u{9d}" (str.++ "U" (str.++ "P" (str.++ "D" (str.++ "A" (str.++ "T" (str.++ "E" (str.++ "\u{85}" (str.++ "\u{aa}" (str.++ "\u{85}" (str.++ "\u{0d}" (str.++ "\u{85}" (str.++ " " (str.++ "\u{a0}" (str.++ "\u{0b}" (str.++ "S" (str.++ "E" (str.++ "T" (str.++ "\u{a0}" (str.++ "C" (str.++ "h" (str.++ "R" (str.++ "\u{aa}" (str.++ "\u{85}" (str.++ "\u{85}" (str.++ " " (str.++ "W" (str.++ "H" (str.++ "E" (str.++ "R" (str.++ "E" (str.++ "\u{c2}" "")))))))))))))))))))))))))))))))))
;witness2: "\x15\u00C5\x1F\u008CUPDATE\xA\u00D4\u00AA\u00A0\u00A0\u0085SET G\u00A0\u0085WHERE\u00AC\u00D0"
(define-fun Witness2 () String (str.++ "\u{15}" (str.++ "\u{c5}" (str.++ "\u{1f}" (str.++ "\u{8c}" (str.++ "U" (str.++ "P" (str.++ "D" (str.++ "A" (str.++ "T" (str.++ "E" (str.++ "\u{0a}" (str.++ "\u{d4}" (str.++ "\u{aa}" (str.++ "\u{a0}" (str.++ "\u{a0}" (str.++ "\u{85}" (str.++ "S" (str.++ "E" (str.++ "T" (str.++ " " (str.++ "G" (str.++ "\u{a0}" (str.++ "\u{85}" (str.++ "W" (str.++ "H" (str.++ "E" (str.++ "R" (str.++ "E" (str.++ "\u{ac}" (str.++ "\u{d0}" "")))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.++ (str.to_re (str.++ "U" (str.++ "P" (str.++ "D" (str.++ "A" (str.++ "T" (str.++ "E" ""))))))) (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (str.to_re (str.++ "S" (str.++ "E" (str.++ "T" ""))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "*" ",")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}")(re.union (re.range "\u{a0}" "\u{a0}")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.++ (str.to_re (str.++ "W" (str.++ "H" (str.++ "E" (str.++ "R" (str.++ "E" "")))))) (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
