;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^<(?:@[a-z0-9][a-z0-9-]*[a-z0-9](?:\.[a-z0-9][a-z0-9-]*[a-z0-9])+(?:,@[a-z0-9][a-z0-9-]*[a-z0-9](?:\.[a-z0-9][a-z0-9-]*[a-z0-9])+)*:)?([a-zA-Z0-9!#\$%&'\*\+\-\/=\?\^_`{\|}~]+(?:\.[a-zA-Z0-9!#\$%&'\*\+\-\/=\?\^_`{\|}~]+)*@[a-z0-9][a-z0-9-]*[a-z0-9](?:\.[a-z0-9][a-z0-9-]*[a-z0-9])+)>$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "<@xj.yo8.4q6.9-9:0D~P/$j@njf----x5.85>"
(define-fun Witness1 () String (str.++ "<" (str.++ "@" (str.++ "x" (str.++ "j" (str.++ "." (str.++ "y" (str.++ "o" (str.++ "8" (str.++ "." (str.++ "4" (str.++ "q" (str.++ "6" (str.++ "." (str.++ "9" (str.++ "-" (str.++ "9" (str.++ ":" (str.++ "0" (str.++ "D" (str.++ "~" (str.++ "P" (str.++ "/" (str.++ "$" (str.++ "j" (str.++ "@" (str.++ "n" (str.++ "j" (str.++ "f" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "x" (str.++ "5" (str.++ "." (str.++ "8" (str.++ "5" (str.++ ">" "")))))))))))))))))))))))))))))))))))))))
;witness2: "<@gs0.gy:|@9o.9n>"
(define-fun Witness2 () String (str.++ "<" (str.++ "@" (str.++ "g" (str.++ "s" (str.++ "0" (str.++ "." (str.++ "g" (str.++ "y" (str.++ ":" (str.++ "|" (str.++ "@" (str.++ "9" (str.++ "o" (str.++ "." (str.++ "9" (str.++ "n" (str.++ ">" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "<" "<")(re.++ (re.opt (re.++ (re.range "@" "@")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z"))))))(re.++ (re.* (re.++ (str.to_re (str.++ "," (str.++ "@" "")))(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z")) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z"))))))))))) (re.range ":" ":"))))))))(re.++ (re.++ (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "~"))))))))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "~"))))))))))))(re.++ (re.range "@" "@")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z")) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z"))))))))))))(re.++ (re.range ">" ">") (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
