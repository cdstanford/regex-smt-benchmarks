;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]+((((\-)|(\s))[a-zA-Z]+)?(,(\s)?(((j|J)|(s|S))(r|R)(\.)?|II|III|IV))?)?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "N,II"
(define-fun Witness1 () String (str.++ "N" (str.++ "," (str.++ "I" (str.++ "I" "")))))
;witness2: "X"
(define-fun Witness2 () String (str.++ "X" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.opt (re.++ (re.union (re.range "-" "-") (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.+ (re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.opt (re.++ (re.range "," ",")(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.union (re.++ (re.union (re.union (re.range "J" "J") (re.range "j" "j")) (re.union (re.range "S" "S") (re.range "s" "s")))(re.++ (re.union (re.range "R" "R") (re.range "r" "r")) (re.opt (re.range "." "."))))(re.union (str.to_re (str.++ "I" (str.++ "I" "")))(re.union (str.to_re (str.++ "I" (str.++ "I" (str.++ "I" "")))) (str.to_re (str.++ "I" (str.++ "V" ""))))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
