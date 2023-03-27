;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;a [a-zA-Z0-9 =&quot;'.:;?]*href=*[a-zA-Z0-9 =&quot;'.:;&gt;?]*[^&gt;]*&gt;([a-zA-Z0-9 =&quot;'.:;&gt;?]*[^&lt;]*&lt;)\s*/a\s*&gt;
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "&lt;a \'.hrefNu&gt;E.3c&lt;/a&gt;E"
(define-fun Witness1 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "a" (str.++ " " (str.++ "'" (str.++ "." (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "N" (str.++ "u" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "E" (str.++ "." (str.++ "3" (str.++ "c" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "a" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "E" ""))))))))))))))))))))))))))))))))))
;witness2: "&lt;a href===3%&gt;V6&lt; /a&gt;"
(define-fun Witness2 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "a" (str.++ " " (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "=" (str.++ "=" (str.++ "=" (str.++ "3" (str.++ "%" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "V" (str.++ "6" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ " " (str.++ "/" (str.++ "a" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "a" (str.++ " " "")))))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (str.to_re (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" "")))))(re.++ (re.* (re.range "=" "="))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (re.* (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\u{ff}"))))))(re.++ (str.to_re (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))(re.++ (re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (re.* (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "k")(re.union (re.range "m" "s") (re.range "u" "\u{ff}")))))) (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" "")))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (str.to_re (str.++ "/" (str.++ "a" "")))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
