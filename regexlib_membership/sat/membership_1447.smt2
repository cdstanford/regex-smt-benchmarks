;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [v,V,(\\/)](\W|)[i,I,1,l,L](\W|)[a,A,@,(\/\\)](\W|)[g,G](\W|)[r,R](\W|)[a,A,@,(\/\\))]
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "),;)[g,>a"
(define-fun Witness1 () String (str.++ ")" (str.++ "," (str.++ ";" (str.++ ")" (str.++ "[" (str.++ "g" (str.++ "," (str.++ ">" (str.++ "a" ""))))))))))
;witness2: "\x19VL),%r(\u0091\u00D6U\x9\u00B6"
(define-fun Witness2 () String (str.++ "\u{19}" (str.++ "V" (str.++ "L" (str.++ ")" (str.++ "," (str.++ "%" (str.++ "r" (str.++ "(" (str.++ "\u{91}" (str.++ "\u{d6}" (str.++ "U" (str.++ "\u{09}" (str.++ "\u{b6}" ""))))))))))))))

(assert (= regexA (re.++ (re.union (re.range "(" ")")(re.union (re.range "," ",")(re.union (re.range "/" "/")(re.union (re.range "V" "V")(re.union (re.range "\u{5c}" "\u{5c}") (re.range "v" "v"))))))(re.++ (re.union (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}")))))))))) (str.to_re ""))(re.++ (re.union (re.range "," ",")(re.union (re.range "1" "1")(re.union (re.range "I" "I")(re.union (re.range "L" "L")(re.union (re.range "i" "i") (re.range "l" "l"))))))(re.++ (re.union (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}")))))))))) (str.to_re ""))(re.++ (re.union (re.range "(" ")")(re.union (re.range "," ",")(re.union (re.range "/" "/")(re.union (re.range "@" "A")(re.union (re.range "\u{5c}" "\u{5c}") (re.range "a" "a"))))))(re.++ (re.union (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}")))))))))) (str.to_re ""))(re.++ (re.union (re.range "," ",")(re.union (re.range "G" "G") (re.range "g" "g")))(re.++ (re.union (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}")))))))))) (str.to_re ""))(re.++ (re.union (re.range "," ",")(re.union (re.range "R" "R") (re.range "r" "r")))(re.++ (re.union (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}")))))))))) (str.to_re "")) (re.union (re.range "(" ")")(re.union (re.range "," ",")(re.union (re.range "/" "/")(re.union (re.range "@" "A")(re.union (re.range "\u{5c}" "\u{5c}") (re.range "a" "a"))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
