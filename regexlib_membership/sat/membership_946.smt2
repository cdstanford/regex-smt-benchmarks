;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\A|\s)[({\[]*([\^\*\-@#$%<>XxVvOo0ZzTt+'¬](_+|\.)[\^\*\-@#$%<>XxVvOo0ZzTt+'¬]|\._\.|[\^\*@#$%<>XxVOo0ZTt']\-[\^\*@#$%<>XxVOo0ZTt']|>>|><|<<|o[O0]|[O0]o)[)}\]]*[;.?]*['"]?(\Z|\s)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(._.)\u0085x"
(define-fun Witness1 () String (str.++ "(" (str.++ "." (str.++ "_" (str.++ "." (str.++ ")" (str.++ "\u{85}" (str.++ "x" ""))))))))
;witness2: "Oo)"
(define-fun Witness2 () String (str.++ "O" (str.++ "o" (str.++ ")" ""))))

(assert (= regexA (re.++ (re.union (str.to_re "") (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.* (re.union (re.range "(" "(")(re.union (re.range "[" "[") (re.range "{" "{"))))(re.++ (re.union (re.++ (re.union (re.range "#" "%")(re.union (re.range "'" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "0" "0")(re.union (re.range "<" "<")(re.union (re.range ">" ">")(re.union (re.range "@" "@")(re.union (re.range "O" "O")(re.union (re.range "T" "T")(re.union (re.range "V" "V")(re.union (re.range "X" "X")(re.union (re.range "Z" "Z")(re.union (re.range "^" "^")(re.union (re.range "o" "o")(re.union (re.range "t" "t")(re.union (re.range "v" "v")(re.union (re.range "x" "x")(re.union (re.range "z" "z") (re.range "\u{ac}" "\u{ac}"))))))))))))))))))))(re.++ (re.union (re.+ (re.range "_" "_")) (re.range "." ".")) (re.union (re.range "#" "%")(re.union (re.range "'" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "0" "0")(re.union (re.range "<" "<")(re.union (re.range ">" ">")(re.union (re.range "@" "@")(re.union (re.range "O" "O")(re.union (re.range "T" "T")(re.union (re.range "V" "V")(re.union (re.range "X" "X")(re.union (re.range "Z" "Z")(re.union (re.range "^" "^")(re.union (re.range "o" "o")(re.union (re.range "t" "t")(re.union (re.range "v" "v")(re.union (re.range "x" "x")(re.union (re.range "z" "z") (re.range "\u{ac}" "\u{ac}"))))))))))))))))))))))(re.union (str.to_re (str.++ "." (str.++ "_" (str.++ "." ""))))(re.union (re.++ (re.union (re.range "#" "%")(re.union (re.range "'" "'")(re.union (re.range "*" "*")(re.union (re.range "0" "0")(re.union (re.range "<" "<")(re.union (re.range ">" ">")(re.union (re.range "@" "@")(re.union (re.range "O" "O")(re.union (re.range "T" "T")(re.union (re.range "V" "V")(re.union (re.range "X" "X")(re.union (re.range "Z" "Z")(re.union (re.range "^" "^")(re.union (re.range "o" "o")(re.union (re.range "t" "t") (re.range "x" "x"))))))))))))))))(re.++ (re.range "-" "-") (re.union (re.range "#" "%")(re.union (re.range "'" "'")(re.union (re.range "*" "*")(re.union (re.range "0" "0")(re.union (re.range "<" "<")(re.union (re.range ">" ">")(re.union (re.range "@" "@")(re.union (re.range "O" "O")(re.union (re.range "T" "T")(re.union (re.range "V" "V")(re.union (re.range "X" "X")(re.union (re.range "Z" "Z")(re.union (re.range "^" "^")(re.union (re.range "o" "o")(re.union (re.range "t" "t") (re.range "x" "x"))))))))))))))))))(re.union (str.to_re (str.++ ">" (str.++ ">" "")))(re.union (str.to_re (str.++ ">" (str.++ "<" "")))(re.union (str.to_re (str.++ "<" (str.++ "<" "")))(re.union (re.++ (re.range "o" "o") (re.union (re.range "0" "0") (re.range "O" "O"))) (re.++ (re.union (re.range "0" "0") (re.range "O" "O")) (re.range "o" "o")))))))))(re.++ (re.* (re.union (re.range ")" ")")(re.union (re.range "]" "]") (re.range "}" "}"))))(re.++ (re.* (re.union (re.range "." ".")(re.union (re.range ";" ";") (re.range "?" "?"))))(re.++ (re.opt (re.union (re.range "\u{22}" "\u{22}") (re.range "'" "'"))) (re.union (str.to_re "") (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
