;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &amp;lt;/?([a-zA-Z][-A-Za-z\d\.]{0,71})(\s+(\S+)(\s*=\s*([-\w\.]{1,1024}|&amp;quot;[^&amp;quot;]{0,1024}&amp;quot;|'[^']{0,1024}'))?)*\s*&amp;gt;
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "&amp;lt;/z- \u0085\u00A0\u0085\u00C0\u00C8\u00D1_\u00B5&amp;gt;"
(define-fun Witness1 () String (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "z" (seq.++ "-" (seq.++ " " (seq.++ "\x85" (seq.++ "\xa0" (seq.++ "\x85" (seq.++ "\xc0" (seq.++ "\xc8" (seq.++ "\xd1" (seq.++ "_" (seq.++ "\xb5" (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))))))))))))))))))))))))))
;witness2: "&amp;lt;/yCc\u00A0\xB&amp;gt;\u00E0"
(define-fun Witness2 () String (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "y" (seq.++ "C" (seq.++ "c" (seq.++ "\xa0" (seq.++ "\x0b" (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "\xe0" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "l" (seq.++ "t" (seq.++ ";" "")))))))))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) ((_ re.loop 0 71) (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.* (re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))) (re.opt (re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union ((_ re.loop 1 1024) (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.union (re.++ (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))))))(re.++ ((_ re.loop 0 1024) (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "`")(re.union (re.range "b" "l")(re.union (re.range "n" "n")(re.union (re.range "r" "s") (re.range "v" "\xff")))))))) (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" ""))))))))))))) (re.++ (re.range "'" "'")(re.++ ((_ re.loop 0 1024) (re.union (re.range "\x00" "&") (re.range "(" "\xff"))) (re.range "'" "'"))))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re (seq.++ "&" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ ";" (seq.++ "g" (seq.++ "t" (seq.++ ";" ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
