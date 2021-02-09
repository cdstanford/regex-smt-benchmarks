;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^<(?:@[a-z0-9][a-z0-9-]*[a-z0-9](?:\.[a-z0-9][a-z0-9-]*[a-z0-9])+(?:,@[a-z0-9][a-z0-9-]*[a-z0-9](?:\.[a-z0-9][a-z0-9-]*[a-z0-9])+)*:)?([a-zA-Z0-9!#\$%&'\*\+\-\/=\?\^_`{\|}~]+(?:\.[a-zA-Z0-9!#\$%&'\*\+\-\/=\?\^_`{\|}~]+)*@[a-z0-9][a-z0-9-]*[a-z0-9](?:\.[a-z0-9][a-z0-9-]*[a-z0-9])+)>$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "<@xj.yo8.4q6.9-9:0D~P/$j@njf----x5.85>"
(define-fun Witness1 () String (seq.++ "<" (seq.++ "@" (seq.++ "x" (seq.++ "j" (seq.++ "." (seq.++ "y" (seq.++ "o" (seq.++ "8" (seq.++ "." (seq.++ "4" (seq.++ "q" (seq.++ "6" (seq.++ "." (seq.++ "9" (seq.++ "-" (seq.++ "9" (seq.++ ":" (seq.++ "0" (seq.++ "D" (seq.++ "~" (seq.++ "P" (seq.++ "/" (seq.++ "$" (seq.++ "j" (seq.++ "@" (seq.++ "n" (seq.++ "j" (seq.++ "f" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "x" (seq.++ "5" (seq.++ "." (seq.++ "8" (seq.++ "5" (seq.++ ">" "")))))))))))))))))))))))))))))))))))))))
;witness2: "<@gs0.gy:|@9o.9n>"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "@" (seq.++ "g" (seq.++ "s" (seq.++ "0" (seq.++ "." (seq.++ "g" (seq.++ "y" (seq.++ ":" (seq.++ "|" (seq.++ "@" (seq.++ "9" (seq.++ "o" (seq.++ "." (seq.++ "9" (seq.++ "n" (seq.++ ">" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "<" "<")(re.++ (re.opt (re.++ (re.range "@" "@")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z"))))))(re.++ (re.* (re.++ (str.to_re (seq.++ "," (seq.++ "@" "")))(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z")) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z"))))))))))) (re.range ":" ":"))))))))(re.++ (re.++ (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "~"))))))))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "~"))))))))))))(re.++ (re.range "@" "@")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z")) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z"))))))))))))(re.++ (re.range ">" ">") (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
