;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\A|\s)(((>[:;=+])|[>:;=+])[,*]?[-~+o]?(\)+|\(+|\}+|\{+|\]+|\[+|\|+|\\+|/+|>+|<+|D+|[@#!OoPpXxZS$03])|>?[xX8][-~+o]?(\)+|\(+|\}+|\{+|\]+|\[+|\|+|\\+|/+|>+|<+|D+))(\Z|\s)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ">:\\\\\"
(define-fun Witness1 () String (seq.++ ">" (seq.++ ":" (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "\x5c" ""))))))))
;witness2: " +,]"
(define-fun Witness2 () String (seq.++ " " (seq.++ "+" (seq.++ "," (seq.++ "]" "")))))

(assert (= regexA (re.++ (re.union (str.to_re "") (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.++ (re.union (re.++ (re.range ">" ">") (re.union (re.range "+" "+")(re.union (re.range ":" ";") (re.range "=" "=")))) (re.union (re.range "+" "+")(re.union (re.range ":" ";") (re.range "=" ">"))))(re.++ (re.opt (re.union (re.range "*" "*") (re.range "," ",")))(re.++ (re.opt (re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "o" "o") (re.range "~" "~"))))) (re.union (re.+ (re.range ")" ")"))(re.union (re.+ (re.range "(" "("))(re.union (re.+ (re.range "}" "}"))(re.union (re.+ (re.range "{" "{"))(re.union (re.+ (re.range "]" "]"))(re.union (re.+ (re.range "[" "["))(re.union (re.+ (re.range "|" "|"))(re.union (re.+ (re.range "\x5c" "\x5c"))(re.union (re.+ (re.range "/" "/"))(re.union (re.+ (re.range ">" ">"))(re.union (re.+ (re.range "<" "<"))(re.union (re.+ (re.range "D" "D")) (re.union (re.range "!" "!")(re.union (re.range "#" "$")(re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "@" "@")(re.union (re.range "O" "P")(re.union (re.range "S" "S")(re.union (re.range "X" "X")(re.union (re.range "Z" "Z")(re.union (re.range "o" "p") (re.range "x" "x")))))))))))))))))))))))))) (re.++ (re.opt (re.range ">" ">"))(re.++ (re.union (re.range "8" "8")(re.union (re.range "X" "X") (re.range "x" "x")))(re.++ (re.opt (re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "o" "o") (re.range "~" "~"))))) (re.union (re.+ (re.range ")" ")"))(re.union (re.+ (re.range "(" "("))(re.union (re.+ (re.range "}" "}"))(re.union (re.+ (re.range "{" "{"))(re.union (re.+ (re.range "]" "]"))(re.union (re.+ (re.range "[" "["))(re.union (re.+ (re.range "|" "|"))(re.union (re.+ (re.range "\x5c" "\x5c"))(re.union (re.+ (re.range "/" "/"))(re.union (re.+ (re.range ">" ">"))(re.union (re.+ (re.range "<" "<")) (re.+ (re.range "D" "D"))))))))))))))))) (re.union (str.to_re "") (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
