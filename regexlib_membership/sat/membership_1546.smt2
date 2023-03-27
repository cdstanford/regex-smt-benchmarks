;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\W{0,5}[Rr]e:\W[a-zA-Z0-9]{1,10},\W[a-z]{1,10}\W[a-z]{1,10}\W[a-z]{1,10}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Re:{6,\u00A0c^huyj`ej"
(define-fun Witness1 () String (str.++ "R" (str.++ "e" (str.++ ":" (str.++ "{" (str.++ "6" (str.++ "," (str.++ "\u{a0}" (str.++ "c" (str.++ "^" (str.++ "h" (str.++ "u" (str.++ "y" (str.++ "j" (str.++ "`" (str.++ "e" (str.++ "j" "")))))))))))))))))
;witness2: "re:*9GR,>zz@b\u00B4c"
(define-fun Witness2 () String (str.++ "r" (str.++ "e" (str.++ ":" (str.++ "*" (str.++ "9" (str.++ "G" (str.++ "R" (str.++ "," (str.++ ">" (str.++ "z" (str.++ "z" (str.++ "@" (str.++ "b" (str.++ "\u{b4}" (str.++ "c" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 0 5) (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}")))))))))))(re.++ (re.union (re.range "R" "R") (re.range "r" "r"))(re.++ (str.to_re (str.++ "e" (str.++ ":" "")))(re.++ (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}"))))))))))(re.++ ((_ re.loop 1 10) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "," ",")(re.++ (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}"))))))))))(re.++ ((_ re.loop 1 10) (re.range "a" "z"))(re.++ (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}"))))))))))(re.++ ((_ re.loop 1 10) (re.range "a" "z"))(re.++ (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}")))))))))) ((_ re.loop 1 10) (re.range "a" "z"))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
