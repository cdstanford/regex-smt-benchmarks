;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <\s*/?\s*\w+(\s*\w+\s*=\s*(['"][^'"]*['"]|[\w#]+))*\s*/?\s*>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0080q[</\u00AA 8=\x9\"\u00AAM\u0086\'E\u0085\u0085=\"\"S\u00BA\u00F2_\u00AA\u00A0=#\u00A0\u0085\u0085G\u00AA7\u00E5r=\u0085\'\'\u00BA\xC=\u0085pa=2\u00A0 \u0085\u00AA3\u00A0\u00A0\u0085=\u0085\u00E69t \x9\u0085\xC>"
(define-fun Witness1 () String (seq.++ "\x80" (seq.++ "q" (seq.++ "[" (seq.++ "<" (seq.++ "/" (seq.++ "\xaa" (seq.++ " " (seq.++ "8" (seq.++ "=" (seq.++ "\x09" (seq.++ "\x22" (seq.++ "\xaa" (seq.++ "M" (seq.++ "\x86" (seq.++ "'" (seq.++ "E" (seq.++ "\x85" (seq.++ "\x85" (seq.++ "=" (seq.++ "\x22" (seq.++ "\x22" (seq.++ "S" (seq.++ "\xba" (seq.++ "\xf2" (seq.++ "_" (seq.++ "\xaa" (seq.++ "\xa0" (seq.++ "=" (seq.++ "#" (seq.++ "\xa0" (seq.++ "\x85" (seq.++ "\x85" (seq.++ "G" (seq.++ "\xaa" (seq.++ "7" (seq.++ "\xe5" (seq.++ "r" (seq.++ "=" (seq.++ "\x85" (seq.++ "'" (seq.++ "'" (seq.++ "\xba" (seq.++ "\x0c" (seq.++ "=" (seq.++ "\x85" (seq.++ "p" (seq.++ "a" (seq.++ "=" (seq.++ "2" (seq.++ "\xa0" (seq.++ " " (seq.++ "\x85" (seq.++ "\xaa" (seq.++ "3" (seq.++ "\xa0" (seq.++ "\xa0" (seq.++ "\x85" (seq.++ "=" (seq.++ "\x85" (seq.++ "\xe6" (seq.++ "9" (seq.++ "t" (seq.++ " " (seq.++ "\x09" (seq.++ "\x85" (seq.++ "\x0c" (seq.++ ">" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "<  \u00B5PQ\u00AA \u00A0\u0085\u00A0/ \xD>\u00DB3"
(define-fun Witness2 () String (seq.++ "<" (seq.++ " " (seq.++ " " (seq.++ "\xb5" (seq.++ "P" (seq.++ "Q" (seq.++ "\xaa" (seq.++ " " (seq.++ "\xa0" (seq.++ "\x85" (seq.++ "\xa0" (seq.++ "/" (seq.++ " " (seq.++ "\x0d" (seq.++ ">" (seq.++ "\xdb" (seq.++ "3" ""))))))))))))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union (re.++ (re.union (re.range "\x22" "\x22") (re.range "'" "'"))(re.++ (re.* (re.union (re.range "\x00" "!")(re.union (re.range "#" "&") (re.range "(" "\xff")))) (re.union (re.range "\x22" "\x22") (re.range "'" "'")))) (re.+ (re.union (re.range "#" "#")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.range ">" ">"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
