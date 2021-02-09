;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[-\w'+*$^&%=~!?{}#|/`]{1}([-\w'+*$^&%=~!?{}#|`.]?[-\w'+*$^&%=~!?{}#|`]{1}){0,31}[-\w'+*$^&%=~!?{}#|`]?@(([a-zA-Z0-9]{1}([-a-zA-Z0-9]?[a-zA-Z0-9]{1}){0,31})\.{1})+([a-zA-Z]{2}|[a-zA-Z]{3}|[a-zA-Z]{4}|[a-zA-Z]{6}){1}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "2\u00E2$l\u00E7KE@6GRRH89.dgrezv"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "\xe2" (seq.++ "$" (seq.++ "l" (seq.++ "\xe7" (seq.++ "K" (seq.++ "E" (seq.++ "@" (seq.++ "6" (seq.++ "G" (seq.++ "R" (seq.++ "R" (seq.++ "H" (seq.++ "8" (seq.++ "9" (seq.++ "." (seq.++ "d" (seq.++ "g" (seq.++ "r" (seq.++ "e" (seq.++ "z" (seq.++ "v" "")))))))))))))))))))))))
;witness2: "ugN\u00DA@UWIf4.sRXz"
(define-fun Witness2 () String (seq.++ "u" (seq.++ "g" (seq.++ "N" (seq.++ "\xda" (seq.++ "@" (seq.++ "U" (seq.++ "W" (seq.++ "I" (seq.++ "f" (seq.++ "4" (seq.++ "." (seq.++ "s" (seq.++ "R" (seq.++ "X" (seq.++ "z" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "^" "~")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))(re.++ ((_ re.loop 0 31) (re.++ (re.opt (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "^" "~")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))) (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "^" "~")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))(re.++ (re.opt (re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "^" "~")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) ((_ re.loop 0 31) (re.++ (re.opt (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.range "." ".")))(re.++ (re.union ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.union ((_ re.loop 3 3) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.union ((_ re.loop 4 4) (re.union (re.range "A" "Z") (re.range "a" "z"))) ((_ re.loop 6 6) (re.union (re.range "A" "Z") (re.range "a" "z")))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
