;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (jar:)?file:/(([A-Z]:)?/([A-Z0-9\*\()\+\-\&$#@_.!~\[\]/])+)((/[A-Z0-9_()\[\]\-=\+_~]+\.jar!)|([^!])(/com/regexlib/example/))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "file:/V:/)s/com/regexlib/example/\u00D2\x16"
(define-fun Witness1 () String (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ ":" (seq.++ "/" (seq.++ "V" (seq.++ ":" (seq.++ "/" (seq.++ ")" (seq.++ "s" (seq.++ "/" (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "r" (seq.++ "e" (seq.++ "g" (seq.++ "e" (seq.++ "x" (seq.++ "l" (seq.++ "i" (seq.++ "b" (seq.++ "/" (seq.++ "e" (seq.++ "x" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ "l" (seq.++ "e" (seq.++ "/" (seq.++ "\xd2" (seq.++ "\x16" ""))))))))))))))))))))))))))))))))))))
;witness2: "\u00A5\x7file:/P:/0\u008F/com/regexlib/example/"
(define-fun Witness2 () String (seq.++ "\xa5" (seq.++ "\x07" (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ ":" (seq.++ "/" (seq.++ "P" (seq.++ ":" (seq.++ "/" (seq.++ "0" (seq.++ "\x8f" (seq.++ "/" (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "r" (seq.++ "e" (seq.++ "g" (seq.++ "e" (seq.++ "x" (seq.++ "l" (seq.++ "i" (seq.++ "b" (seq.++ "/" (seq.++ "e" (seq.++ "x" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ "l" (seq.++ "e" (seq.++ "/" ""))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (str.to_re (seq.++ "j" (seq.++ "a" (seq.++ "r" (seq.++ ":" ""))))))(re.++ (str.to_re (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ ":" (seq.++ "/" "")))))))(re.++ (re.++ (re.opt (re.++ (re.range "A" "Z") (re.range ":" ":")))(re.++ (re.range "/" "/") (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "$")(re.union (re.range "&" "&")(re.union (re.range "(" "+")(re.union (re.range "-" "9")(re.union (re.range "@" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "_") (re.range "~" "~")))))))))))) (re.union (re.++ (re.range "/" "/")(re.++ (re.+ (re.union (re.range "(" ")")(re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "A" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "_") (re.range "~" "~")))))))))) (str.to_re (seq.++ "." (seq.++ "j" (seq.++ "a" (seq.++ "r" (seq.++ "!" "")))))))) (re.++ (re.union (re.range "\x00" " ") (re.range "\x22" "\xff")) (str.to_re (seq.++ "/" (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "r" (seq.++ "e" (seq.++ "g" (seq.++ "e" (seq.++ "x" (seq.++ "l" (seq.++ "i" (seq.++ "b" (seq.++ "/" (seq.++ "e" (seq.++ "x" (seq.++ "a" (seq.++ "m" (seq.++ "p" (seq.++ "l" (seq.++ "e" (seq.++ "/" ""))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
