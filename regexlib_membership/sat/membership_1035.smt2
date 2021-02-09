;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;a [a-zA-Z0-9 =&quot;'.:;?]*href=*[a-zA-Z0-9 =&quot;'.:;&gt;?]*[^&gt;]*&gt;([a-zA-Z0-9 =&quot;'.:;&gt;?]*[^&lt;]*&lt;)\s*/a\s*&gt;
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "&lt;a \'.hrefNu&gt;E.3c&lt;/a&gt;E"
(define-fun Witness1 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "a" (seq.++ " " (seq.++ "'" (seq.++ "." (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "N" (seq.++ "u" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "E" (seq.++ "." (seq.++ "3" (seq.++ "c" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "a" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "E" ""))))))))))))))))))))))))))))))))))
;witness2: "&lt;a href===3%&gt;V6&lt; /a&gt;"
(define-fun Witness2 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "a" (seq.++ " " (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "=" (seq.++ "=" (seq.++ "=" (seq.++ "3" (seq.++ "%" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "V" (seq.++ "6" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ " " (seq.++ "/" (seq.++ "a" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "a" (seq.++ " " "")))))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (str.to_re (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" "")))))(re.++ (re.* (re.range "=" "="))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (re.* (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\xff"))))))(re.++ (str.to_re (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))(re.++ (re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (re.* (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "k")(re.union (re.range "m" "s") (re.range "u" "\xff")))))) (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" "")))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (str.to_re (seq.++ "/" (seq.++ "a" "")))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
