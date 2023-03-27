;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z][a-z]+(o(i|u)(n|(v)?r(t)?|s|t|x)(e(s)?)?)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Xxouvrt"
(define-fun Witness1 () String (str.++ "X" (str.++ "x" (str.++ "o" (str.++ "u" (str.++ "v" (str.++ "r" (str.++ "t" ""))))))))
;witness2: "Ufkoire"
(define-fun Witness2 () String (str.++ "U" (str.++ "f" (str.++ "k" (str.++ "o" (str.++ "i" (str.++ "r" (str.++ "e" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.++ (re.range "o" "o")(re.++ (re.union (re.range "i" "i") (re.range "u" "u"))(re.++ (re.union (re.range "n" "n")(re.union (re.++ (re.opt (re.range "v" "v"))(re.++ (re.range "r" "r") (re.opt (re.range "t" "t")))) (re.union (re.range "s" "t") (re.range "x" "x")))) (re.opt (re.++ (re.range "e" "e") (re.opt (re.range "s" "s"))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
