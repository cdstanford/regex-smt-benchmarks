;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;a[a-zA-Z0-9 =&quot;'.:;?]*(name=){1}[a-zA-Z0-9 =&quot;'.:;?]*\s*((/&gt;)|(&gt;[a-zA-Z0-9 =&quot;'&lt;&gt;.:;?]*&lt;/a&gt;))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0083\u009A&lt;aname=/&gt;\x2\u0086"
(define-fun Witness1 () String (str.++ "\u{83}" (str.++ "\u{9a}" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "a" (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" (str.++ "=" (str.++ "/" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "\u{02}" (str.++ "\u{86}" ""))))))))))))))))))))
;witness2: "&lt;azZ.M5name=&gt;&lt;/a&gt;2P\u00F9"
(define-fun Witness2 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "a" (str.++ "z" (str.++ "Z" (str.++ "." (str.++ "M" (str.++ "5" (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" (str.++ "=" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "a" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "2" (str.++ "P" (str.++ "\u{f9}" "")))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "a" ""))))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (str.to_re (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" (str.++ "=" ""))))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.union (str.to_re (str.++ "/" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))) (re.++ (str.to_re (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "." ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))) (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "a" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
