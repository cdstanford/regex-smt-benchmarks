;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z][a-z]+((i)?e(a)?(u)?[r(re)?|x]?)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Noawea"
(define-fun Witness1 () String (str.++ "N" (str.++ "o" (str.++ "a" (str.++ "w" (str.++ "e" (str.++ "a" "")))))))
;witness2: "Zwieue"
(define-fun Witness2 () String (str.++ "Z" (str.++ "w" (str.++ "i" (str.++ "e" (str.++ "u" (str.++ "e" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.++ (re.opt (re.range "i" "i"))(re.++ (re.range "e" "e")(re.++ (re.opt (re.range "a" "a"))(re.++ (re.opt (re.range "u" "u")) (re.opt (re.union (re.range "(" ")")(re.union (re.range "?" "?")(re.union (re.range "e" "e")(re.union (re.range "r" "r")(re.union (re.range "x" "x") (re.range "|" "|"))))))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
