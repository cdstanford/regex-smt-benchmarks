;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((?-i)A[cglmrstu]|B[aehikr]?|C[adeflmorsu]?|D[bsy]|E[rsu]|F[emf]?|G[ade]|H[efgos]?|I[nk]?|Kr?|L[airu]|M[dgnot]|N[abdeiop]|Os?|P[abdmortu]?|R[abefghnu]|S[bcegimnr]?|T[abcehil]|U(u[bhopqst])?|V|W|Xe|Yb?|Z[nr])$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Zn"
(define-fun Witness1 () String (seq.++ "Z" (seq.++ "n" "")))
;witness2: "Ac"
(define-fun Witness2 () String (seq.++ "A" (seq.++ "c" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "A" "A") (re.union (re.range "c" "c")(re.union (re.range "g" "g")(re.union (re.range "l" "m") (re.range "r" "u")))))(re.union (re.++ (re.range "B" "B") (re.opt (re.union (re.range "a" "a")(re.union (re.range "e" "e")(re.union (re.range "h" "i")(re.union (re.range "k" "k") (re.range "r" "r")))))))(re.union (re.++ (re.range "C" "C") (re.opt (re.union (re.range "a" "a")(re.union (re.range "d" "f")(re.union (re.range "l" "m")(re.union (re.range "o" "o")(re.union (re.range "r" "s") (re.range "u" "u"))))))))(re.union (re.++ (re.range "D" "D") (re.union (re.range "b" "b")(re.union (re.range "s" "s") (re.range "y" "y"))))(re.union (re.++ (re.range "E" "E") (re.union (re.range "r" "s") (re.range "u" "u")))(re.union (re.++ (re.range "F" "F") (re.opt (re.union (re.range "e" "f") (re.range "m" "m"))))(re.union (re.++ (re.range "G" "G") (re.union (re.range "a" "a") (re.range "d" "e")))(re.union (re.++ (re.range "H" "H") (re.opt (re.union (re.range "e" "g")(re.union (re.range "o" "o") (re.range "s" "s")))))(re.union (re.++ (re.range "I" "I") (re.opt (re.union (re.range "k" "k") (re.range "n" "n"))))(re.union (re.++ (re.range "K" "K") (re.opt (re.range "r" "r")))(re.union (re.++ (re.range "L" "L") (re.union (re.range "a" "a")(re.union (re.range "i" "i")(re.union (re.range "r" "r") (re.range "u" "u")))))(re.union (re.++ (re.range "M" "M") (re.union (re.range "d" "d")(re.union (re.range "g" "g")(re.union (re.range "n" "o") (re.range "t" "t")))))(re.union (re.++ (re.range "N" "N") (re.union (re.range "a" "b")(re.union (re.range "d" "e")(re.union (re.range "i" "i") (re.range "o" "p")))))(re.union (re.++ (re.range "O" "O") (re.opt (re.range "s" "s")))(re.union (re.++ (re.range "P" "P") (re.opt (re.union (re.range "a" "b")(re.union (re.range "d" "d")(re.union (re.range "m" "m")(re.union (re.range "o" "o")(re.union (re.range "r" "r") (re.range "t" "u"))))))))(re.union (re.++ (re.range "R" "R") (re.union (re.range "a" "b")(re.union (re.range "e" "h")(re.union (re.range "n" "n") (re.range "u" "u")))))(re.union (re.++ (re.range "S" "S") (re.opt (re.union (re.range "b" "c")(re.union (re.range "e" "e")(re.union (re.range "g" "g")(re.union (re.range "i" "i")(re.union (re.range "m" "n") (re.range "r" "r"))))))))(re.union (re.++ (re.range "T" "T") (re.union (re.range "a" "c")(re.union (re.range "e" "e")(re.union (re.range "h" "i") (re.range "l" "l")))))(re.union (re.++ (re.range "U" "U") (re.opt (re.++ (re.range "u" "u") (re.union (re.range "b" "b")(re.union (re.range "h" "h")(re.union (re.range "o" "q") (re.range "s" "t")))))))(re.union (re.range "V" "W")(re.union (str.to_re (seq.++ "X" (seq.++ "e" "")))(re.union (re.++ (re.range "Y" "Y") (re.opt (re.range "b" "b"))) (re.++ (re.range "Z" "Z") (re.union (re.range "n" "n") (re.range "r" "r"))))))))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
