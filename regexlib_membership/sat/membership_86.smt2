;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [a-zA-Z0-9!#\$%&'\*\+\-\/=\?\^_`{\|}~]+(?:\.[a-zA-Z0-9!#\$%&'\*\+\-\/=\?\^_`{\|}~]+)*@[a-z0-9][a-z0-9-]*[a-z0-9](?:\.[a-z0-9][a-z0-9-]*[a-z0-9])+
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "l#.!@9l.6z3.53U"
(define-fun Witness1 () String (seq.++ "l" (seq.++ "#" (seq.++ "." (seq.++ "!" (seq.++ "@" (seq.++ "9" (seq.++ "l" (seq.++ "." (seq.++ "6" (seq.++ "z" (seq.++ "3" (seq.++ "." (seq.++ "5" (seq.++ "3" (seq.++ "U" ""))))))))))))))))
;witness2: "\u00BFw\x4H@zw.9hz.92.98.g3.8j.s9f"
(define-fun Witness2 () String (seq.++ "\xbf" (seq.++ "w" (seq.++ "\x04" (seq.++ "H" (seq.++ "@" (seq.++ "z" (seq.++ "w" (seq.++ "." (seq.++ "9" (seq.++ "h" (seq.++ "z" (seq.++ "." (seq.++ "9" (seq.++ "2" (seq.++ "." (seq.++ "9" (seq.++ "8" (seq.++ "." (seq.++ "g" (seq.++ "3" (seq.++ "." (seq.++ "8" (seq.++ "j" (seq.++ "." (seq.++ "s" (seq.++ "9" (seq.++ "f" ""))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "~"))))))))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "~"))))))))))))(re.++ (re.range "@" "@")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z")) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
