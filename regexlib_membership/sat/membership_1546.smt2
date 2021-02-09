;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\W{0,5}[Rr]e:\W[a-zA-Z0-9]{1,10},\W[a-z]{1,10}\W[a-z]{1,10}\W[a-z]{1,10}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Re:{6,\u00A0c^huyj`ej"
(define-fun Witness1 () String (seq.++ "R" (seq.++ "e" (seq.++ ":" (seq.++ "{" (seq.++ "6" (seq.++ "," (seq.++ "\xa0" (seq.++ "c" (seq.++ "^" (seq.++ "h" (seq.++ "u" (seq.++ "y" (seq.++ "j" (seq.++ "`" (seq.++ "e" (seq.++ "j" "")))))))))))))))))
;witness2: "re:*9GR,>zz@b\u00B4c"
(define-fun Witness2 () String (seq.++ "r" (seq.++ "e" (seq.++ ":" (seq.++ "*" (seq.++ "9" (seq.++ "G" (seq.++ "R" (seq.++ "," (seq.++ ">" (seq.++ "z" (seq.++ "z" (seq.++ "@" (seq.++ "b" (seq.++ "\xb4" (seq.++ "c" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 0 5) (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7")))))))))))(re.++ (re.union (re.range "R" "R") (re.range "r" "r"))(re.++ (str.to_re (seq.++ "e" (seq.++ ":" "")))(re.++ (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7"))))))))))(re.++ ((_ re.loop 1 10) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "," ",")(re.++ (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7"))))))))))(re.++ ((_ re.loop 1 10) (re.range "a" "z"))(re.++ (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7"))))))))))(re.++ ((_ re.loop 1 10) (re.range "a" "z"))(re.++ (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7")))))))))) ((_ re.loop 1 10) (re.range "a" "z"))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
