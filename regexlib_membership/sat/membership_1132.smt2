;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;a[a-zA-Z0-9 =&quot;'.?_/]*(href\s*=\s*){1}[a-zA-Z0-9 =&quot;'.?_/]*\s*((/&gt;)|(&gt;[a-zA-Z0-9 =&quot;'&lt;&gt;.?_/]*&lt;/a&gt;))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "&lt;aqhref=\u00A0=x \xD/&gt;/"
(define-fun Witness1 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "a" (seq.++ "q" (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "=" (seq.++ "\xa0" (seq.++ "=" (seq.++ "x" (seq.++ " " (seq.++ "\x0d" (seq.++ "/" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "/" "")))))))))))))))))))))))
;witness2: "&lt;a.?LT4href\xC\u0085=AgA&gt;&lt;/a&gt;\u00C1"
(define-fun Witness2 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "a" (seq.++ "." (seq.++ "?" (seq.++ "L" (seq.++ "T" (seq.++ "4" (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "\x0c" (seq.++ "\x85" (seq.++ "=" (seq.++ "A" (seq.++ "g" (seq.++ "A" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "a" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "\xc1" ""))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "a" ""))))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))(re.++ (re.++ (str.to_re (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" "")))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "=" "=") (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union (str.to_re (seq.++ "/" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))) (re.++ (str.to_re (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))))) (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "a" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
