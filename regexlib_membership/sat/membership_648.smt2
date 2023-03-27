;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z][a-z]+(tz)?(man|berg)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Xwtzman"
(define-fun Witness1 () String (str.++ "X" (str.++ "w" (str.++ "t" (str.++ "z" (str.++ "m" (str.++ "a" (str.++ "n" ""))))))))
;witness2: "Sztzman"
(define-fun Witness2 () String (str.++ "S" (str.++ "z" (str.++ "t" (str.++ "z" (str.++ "m" (str.++ "a" (str.++ "n" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.opt (str.to_re (str.++ "t" (str.++ "z" ""))))(re.++ (re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "n" "")))) (str.to_re (str.++ "b" (str.++ "e" (str.++ "r" (str.++ "g" "")))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
