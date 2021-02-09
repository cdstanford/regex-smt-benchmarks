;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z][a-z]+(tz)?(man|berg)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Xwtzman"
(define-fun Witness1 () String (seq.++ "X" (seq.++ "w" (seq.++ "t" (seq.++ "z" (seq.++ "m" (seq.++ "a" (seq.++ "n" ""))))))))
;witness2: "Sztzman"
(define-fun Witness2 () String (seq.++ "S" (seq.++ "z" (seq.++ "t" (seq.++ "z" (seq.++ "m" (seq.++ "a" (seq.++ "n" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.opt (str.to_re (seq.++ "t" (seq.++ "z" ""))))(re.++ (re.union (str.to_re (seq.++ "m" (seq.++ "a" (seq.++ "n" "")))) (str.to_re (seq.++ "b" (seq.++ "e" (seq.++ "r" (seq.++ "g" "")))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
