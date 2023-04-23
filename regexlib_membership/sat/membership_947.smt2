;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\A|\s)((\)+|\(+|\}+|\{+|\]+|\[+|\|+|\\+|/+|>+|<+|D+|[@#!OoXxZS$0])[-~+o]?[,*]?((<[:;=+])|[<:;=+])|(\)+|\(+|\}+|\{+|\]+|\[+|\|+|\\+|/+|>+|<+|D+)[-~+o]?[xX8]<?)(\Z|\s)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0085\+*+\xD"
(define-fun Witness1 () String (str.++ "\u{85}" (str.++ "\u{5c}" (str.++ "+" (str.++ "*" (str.++ "+" (str.++ "\u{0d}" "")))))))
;witness2: ">>-*<+\u0085"
(define-fun Witness2 () String (str.++ ">" (str.++ ">" (str.++ "-" (str.++ "*" (str.++ "<" (str.++ "+" (str.++ "\u{85}" ""))))))))

(assert (= regexA (re.++ (re.union (str.to_re "") (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.++ (re.union (re.+ (re.range ")" ")"))(re.union (re.+ (re.range "(" "("))(re.union (re.+ (re.range "}" "}"))(re.union (re.+ (re.range "{" "{"))(re.union (re.+ (re.range "]" "]"))(re.union (re.+ (re.range "[" "["))(re.union (re.+ (re.range "|" "|"))(re.union (re.+ (re.range "\u{5c}" "\u{5c}"))(re.union (re.+ (re.range "/" "/"))(re.union (re.+ (re.range ">" ">"))(re.union (re.+ (re.range "<" "<"))(re.union (re.+ (re.range "D" "D")) (re.union (re.range "!" "!")(re.union (re.range "#" "$")(re.union (re.range "0" "0")(re.union (re.range "@" "@")(re.union (re.range "O" "O")(re.union (re.range "S" "S")(re.union (re.range "X" "X")(re.union (re.range "Z" "Z")(re.union (re.range "o" "o") (re.range "x" "x"))))))))))))))))))))))(re.++ (re.opt (re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "o" "o") (re.range "~" "~")))))(re.++ (re.opt (re.union (re.range "*" "*") (re.range "," ","))) (re.union (re.++ (re.range "<" "<") (re.union (re.range "+" "+")(re.union (re.range ":" ";") (re.range "=" "=")))) (re.union (re.range "+" "+") (re.range ":" "=")))))) (re.++ (re.union (re.+ (re.range ")" ")"))(re.union (re.+ (re.range "(" "("))(re.union (re.+ (re.range "}" "}"))(re.union (re.+ (re.range "{" "{"))(re.union (re.+ (re.range "]" "]"))(re.union (re.+ (re.range "[" "["))(re.union (re.+ (re.range "|" "|"))(re.union (re.+ (re.range "\u{5c}" "\u{5c}"))(re.union (re.+ (re.range "/" "/"))(re.union (re.+ (re.range ">" ">"))(re.union (re.+ (re.range "<" "<")) (re.+ (re.range "D" "D")))))))))))))(re.++ (re.opt (re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "o" "o") (re.range "~" "~")))))(re.++ (re.union (re.range "8" "8")(re.union (re.range "X" "X") (re.range "x" "x"))) (re.opt (re.range "<" "<")))))) (re.union (str.to_re "") (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
