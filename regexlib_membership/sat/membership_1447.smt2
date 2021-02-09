;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [v,V,(\\/)](\W|)[i,I,1,l,L](\W|)[a,A,@,(\/\\)](\W|)[g,G](\W|)[r,R](\W|)[a,A,@,(\/\\))]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "),;)[g,>a"
(define-fun Witness1 () String (seq.++ ")" (seq.++ "," (seq.++ ";" (seq.++ ")" (seq.++ "[" (seq.++ "g" (seq.++ "," (seq.++ ">" (seq.++ "a" ""))))))))))
;witness2: "\x19VL),%r(\u0091\u00D6U\x9\u00B6"
(define-fun Witness2 () String (seq.++ "\x19" (seq.++ "V" (seq.++ "L" (seq.++ ")" (seq.++ "," (seq.++ "%" (seq.++ "r" (seq.++ "(" (seq.++ "\x91" (seq.++ "\xd6" (seq.++ "U" (seq.++ "\x09" (seq.++ "\xb6" ""))))))))))))))

(assert (= regexA (re.++ (re.union (re.range "(" ")")(re.union (re.range "," ",")(re.union (re.range "/" "/")(re.union (re.range "V" "V")(re.union (re.range "\x5c" "\x5c") (re.range "v" "v"))))))(re.++ (re.union (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7")))))))))) (str.to_re ""))(re.++ (re.union (re.range "," ",")(re.union (re.range "1" "1")(re.union (re.range "I" "I")(re.union (re.range "L" "L")(re.union (re.range "i" "i") (re.range "l" "l"))))))(re.++ (re.union (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7")))))))))) (str.to_re ""))(re.++ (re.union (re.range "(" ")")(re.union (re.range "," ",")(re.union (re.range "/" "/")(re.union (re.range "@" "A")(re.union (re.range "\x5c" "\x5c") (re.range "a" "a"))))))(re.++ (re.union (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7")))))))))) (str.to_re ""))(re.++ (re.union (re.range "," ",")(re.union (re.range "G" "G") (re.range "g" "g")))(re.++ (re.union (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7")))))))))) (str.to_re ""))(re.++ (re.union (re.range "," ",")(re.union (re.range "R" "R") (re.range "r" "r")))(re.++ (re.union (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7")))))))))) (str.to_re "")) (re.union (re.range "(" ")")(re.union (re.range "," ",")(re.union (re.range "/" "/")(re.union (re.range "@" "A")(re.union (re.range "\x5c" "\x5c") (re.range "a" "a"))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
