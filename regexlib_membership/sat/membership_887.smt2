;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (jar:)?file:/(([A-Z]:)?/([A-Z0-9\*\()\+\-\&$#@_.!~\[\]/])+)((/[A-Z0-9_()\[\]\-=\+_~]+\.jar!)|([^!])(/com/regexlib/example/))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "file:/V:/)s/com/regexlib/example/\u00D2\x16"
(define-fun Witness1 () String (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ ":" (str.++ "/" (str.++ "V" (str.++ ":" (str.++ "/" (str.++ ")" (str.++ "s" (str.++ "/" (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "r" (str.++ "e" (str.++ "g" (str.++ "e" (str.++ "x" (str.++ "l" (str.++ "i" (str.++ "b" (str.++ "/" (str.++ "e" (str.++ "x" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ "l" (str.++ "e" (str.++ "/" (str.++ "\u{d2}" (str.++ "\u{16}" ""))))))))))))))))))))))))))))))))))))
;witness2: "\u00A5\x7file:/P:/0\u008F/com/regexlib/example/"
(define-fun Witness2 () String (str.++ "\u{a5}" (str.++ "\u{07}" (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ ":" (str.++ "/" (str.++ "P" (str.++ ":" (str.++ "/" (str.++ "0" (str.++ "\u{8f}" (str.++ "/" (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "r" (str.++ "e" (str.++ "g" (str.++ "e" (str.++ "x" (str.++ "l" (str.++ "i" (str.++ "b" (str.++ "/" (str.++ "e" (str.++ "x" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ "l" (str.++ "e" (str.++ "/" ""))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (str.to_re (str.++ "j" (str.++ "a" (str.++ "r" (str.++ ":" ""))))))(re.++ (str.to_re (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ ":" (str.++ "/" "")))))))(re.++ (re.++ (re.opt (re.++ (re.range "A" "Z") (re.range ":" ":")))(re.++ (re.range "/" "/") (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "$")(re.union (re.range "&" "&")(re.union (re.range "(" "+")(re.union (re.range "-" "9")(re.union (re.range "@" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "_") (re.range "~" "~")))))))))))) (re.union (re.++ (re.range "/" "/")(re.++ (re.+ (re.union (re.range "(" ")")(re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "A" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "_") (re.range "~" "~")))))))))) (str.to_re (str.++ "." (str.++ "j" (str.++ "a" (str.++ "r" (str.++ "!" "")))))))) (re.++ (re.union (re.range "\u{00}" " ") (re.range "\u{22}" "\u{ff}")) (str.to_re (str.++ "/" (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "r" (str.++ "e" (str.++ "g" (str.++ "e" (str.++ "x" (str.++ "l" (str.++ "i" (str.++ "b" (str.++ "/" (str.++ "e" (str.++ "x" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ "l" (str.++ "e" (str.++ "/" ""))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
