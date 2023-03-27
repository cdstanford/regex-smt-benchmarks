;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <\s*/?\s*\w+(\s*\w+\s*=\s*(['"][^'"]*['"]|[\w#]+))*\s*/?\s*>
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0080q[</\u00AA 8=\x9\"\u00AAM\u0086\'E\u0085\u0085=\"\"S\u00BA\u00F2_\u00AA\u00A0=#\u00A0\u0085\u0085G\u00AA7\u00E5r=\u0085\'\'\u00BA\xC=\u0085pa=2\u00A0 \u0085\u00AA3\u00A0\u00A0\u0085=\u0085\u00E69t \x9\u0085\xC>"
(define-fun Witness1 () String (str.++ "\u{80}" (str.++ "q" (str.++ "[" (str.++ "<" (str.++ "/" (str.++ "\u{aa}" (str.++ " " (str.++ "8" (str.++ "=" (str.++ "\u{09}" (str.++ "\u{22}" (str.++ "\u{aa}" (str.++ "M" (str.++ "\u{86}" (str.++ "'" (str.++ "E" (str.++ "\u{85}" (str.++ "\u{85}" (str.++ "=" (str.++ "\u{22}" (str.++ "\u{22}" (str.++ "S" (str.++ "\u{ba}" (str.++ "\u{f2}" (str.++ "_" (str.++ "\u{aa}" (str.++ "\u{a0}" (str.++ "=" (str.++ "#" (str.++ "\u{a0}" (str.++ "\u{85}" (str.++ "\u{85}" (str.++ "G" (str.++ "\u{aa}" (str.++ "7" (str.++ "\u{e5}" (str.++ "r" (str.++ "=" (str.++ "\u{85}" (str.++ "'" (str.++ "'" (str.++ "\u{ba}" (str.++ "\u{0c}" (str.++ "=" (str.++ "\u{85}" (str.++ "p" (str.++ "a" (str.++ "=" (str.++ "2" (str.++ "\u{a0}" (str.++ " " (str.++ "\u{85}" (str.++ "\u{aa}" (str.++ "3" (str.++ "\u{a0}" (str.++ "\u{a0}" (str.++ "\u{85}" (str.++ "=" (str.++ "\u{85}" (str.++ "\u{e6}" (str.++ "9" (str.++ "t" (str.++ " " (str.++ "\u{09}" (str.++ "\u{85}" (str.++ "\u{0c}" (str.++ ">" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "<  \u00B5PQ\u00AA \u00A0\u0085\u00A0/ \xD>\u00DB3"
(define-fun Witness2 () String (str.++ "<" (str.++ " " (str.++ " " (str.++ "\u{b5}" (str.++ "P" (str.++ "Q" (str.++ "\u{aa}" (str.++ " " (str.++ "\u{a0}" (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ "/" (str.++ " " (str.++ "\u{0d}" (str.++ ">" (str.++ "\u{db}" (str.++ "3" ""))))))))))))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.* (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.union (re.++ (re.union (re.range "\u{22}" "\u{22}") (re.range "'" "'"))(re.++ (re.* (re.union (re.range "\u{00}" "!")(re.union (re.range "#" "&") (re.range "(" "\u{ff}")))) (re.union (re.range "\u{22}" "\u{22}") (re.range "'" "'")))) (re.+ (re.union (re.range "#" "#")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.range ">" ">"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
