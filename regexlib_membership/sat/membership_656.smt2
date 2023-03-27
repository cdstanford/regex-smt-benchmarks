;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z][a-z]+((e(m|ng)|str)a)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Ktema"
(define-fun Witness1 () String (str.++ "K" (str.++ "t" (str.++ "e" (str.++ "m" (str.++ "a" ""))))))
;witness2: "Mqenga"
(define-fun Witness2 () String (str.++ "M" (str.++ "q" (str.++ "e" (str.++ "n" (str.++ "g" (str.++ "a" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.++ (re.union (re.++ (re.range "e" "e") (re.union (re.range "m" "m") (str.to_re (str.++ "n" (str.++ "g" ""))))) (str.to_re (str.++ "s" (str.++ "t" (str.++ "r" ""))))) (re.range "a" "a")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
