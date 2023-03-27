;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [a-zA-Z0-9!#\$%&'\*\+\-\/=\?\^_`{\|}~]+(?:\.[a-zA-Z0-9!#\$%&'\*\+\-\/=\?\^_`{\|}~]+)*@[a-z0-9][a-z0-9-]*[a-z0-9](?:\.[a-z0-9][a-z0-9-]*[a-z0-9])+
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "l#.!@9l.6z3.53U"
(define-fun Witness1 () String (str.++ "l" (str.++ "#" (str.++ "." (str.++ "!" (str.++ "@" (str.++ "9" (str.++ "l" (str.++ "." (str.++ "6" (str.++ "z" (str.++ "3" (str.++ "." (str.++ "5" (str.++ "3" (str.++ "U" ""))))))))))))))))
;witness2: "\u00BFw\x4H@zw.9hz.92.98.g3.8j.s9f"
(define-fun Witness2 () String (str.++ "\u{bf}" (str.++ "w" (str.++ "\u{04}" (str.++ "H" (str.++ "@" (str.++ "z" (str.++ "w" (str.++ "." (str.++ "9" (str.++ "h" (str.++ "z" (str.++ "." (str.++ "9" (str.++ "2" (str.++ "." (str.++ "9" (str.++ "8" (str.++ "." (str.++ "g" (str.++ "3" (str.++ "." (str.++ "8" (str.++ "j" (str.++ "." (str.++ "s" (str.++ "9" (str.++ "f" ""))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "~"))))))))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "~"))))))))))))(re.++ (re.range "@" "@")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z")) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
