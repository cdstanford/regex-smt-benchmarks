;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;a[a-zA-Z0-9 =&quot;'.:;?]*(name=){1}[a-zA-Z0-9 =&quot;'.:;?]*\s*((/&gt;)|(&gt;[a-zA-Z0-9 =&quot;'&lt;&gt;.:;?]*&lt;/a&gt;))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0083\u009A&lt;aname=/&gt;\x2\u0086"
(define-fun Witness1 () String (seq.++ "\x83" (seq.++ "\x9a" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "a" (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" (seq.++ "=" (seq.++ "/" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "\x02" (seq.++ "\x86" ""))))))))))))))))))))
;witness2: "&lt;azZ.M5name=&gt;&lt;/a&gt;2P\u00F9"
(define-fun Witness2 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "a" (seq.++ "z" (seq.++ "Z" (seq.++ "." (seq.++ "M" (seq.++ "5" (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" (seq.++ "=" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "a" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "2" (seq.++ "P" (seq.++ "\xf9" "")))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "a" ""))))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (str.to_re (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" (seq.++ "=" ""))))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union (str.to_re (seq.++ "/" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))) (re.++ (str.to_re (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))) (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "a" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
