;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;a[a-zA-Z0-9 =&quot;'.?_/]*(href\s*=\s*){1}[a-zA-Z0-9 =&quot;'.?_/]*\s*((/&gt;)|(&gt;[a-zA-Z0-9 =&quot;'&lt;&gt;.?_/]*&lt;/a&gt;))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "&lt;aqhref=\u00A0=x \xD/&gt;/"
(define-fun Witness1 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "a" (str.++ "q" (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "=" (str.++ "\u{a0}" (str.++ "=" (str.++ "x" (str.++ " " (str.++ "\u{0d}" (str.++ "/" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "/" "")))))))))))))))))))))))
;witness2: "&lt;a.?LT4href\xC\u0085=AgA&gt;&lt;/a&gt;\u00C1"
(define-fun Witness2 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "a" (str.++ "." (str.++ "?" (str.++ "L" (str.++ "T" (str.++ "4" (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "\u{0c}" (str.++ "\u{85}" (str.++ "=" (str.++ "A" (str.++ "g" (str.++ "A" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "a" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "\u{c1}" ""))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "a" ""))))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))(re.++ (re.++ (str.to_re (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" "")))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "=" "=") (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.union (str.to_re (str.++ "/" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))) (re.++ (str.to_re (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))))) (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "a" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
