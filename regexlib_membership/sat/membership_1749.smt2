;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &amp;lt;/?([a-zA-Z][-A-Za-z\d\.]{0,71})(\s+(\S+)(\s*=\s*([-\w\.]{1,1024}|&amp;quot;[^&amp;quot;]{0,1024}&amp;quot;|'[^']{0,1024}'))?)*\s*&amp;gt;
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "&amp;lt;/z- \u0085\u00A0\u0085\u00C0\u00C8\u00D1_\u00B5&amp;gt;"
(define-fun Witness1 () String (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "z" (str.++ "-" (str.++ " " (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ "\u{85}" (str.++ "\u{c0}" (str.++ "\u{c8}" (str.++ "\u{d1}" (str.++ "_" (str.++ "\u{b5}" (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))))))))))))))))))))))
;witness2: "&amp;lt;/yCc\u00A0\xB&amp;gt;\u00E0"
(define-fun Witness2 () String (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "y" (str.++ "C" (str.++ "c" (str.++ "\u{a0}" (str.++ "\u{0b}" (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "\u{e0}" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "l" (str.++ "t" (str.++ ";" "")))))))))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) ((_ re.loop 0 71) (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.* (re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))) (re.opt (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.union ((_ re.loop 1 1024) (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.union (re.++ (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" "")))))))))))(re.++ ((_ re.loop 0 1024) (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "`")(re.union (re.range "b" "l")(re.union (re.range "n" "n")(re.union (re.range "r" "s") (re.range "v" "\u{ff}")))))))) (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" ""))))))))))))) (re.++ (re.range "'" "'")(re.++ ((_ re.loop 0 1024) (re.union (re.range "\u{00}" "&") (re.range "(" "\u{ff}"))) (re.range "'" "'"))))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re (str.++ "&" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ ";" (str.++ "g" (str.++ "t" (str.++ ";" ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
