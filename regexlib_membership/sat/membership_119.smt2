;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [A-Za-z0-9]+(?:-[A-Za-z0-9]+)*(?:\.[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*)*
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "n-3k"
(define-fun Witness1 () String (str.++ "n" (str.++ "-" (str.++ "3" (str.++ "k" "")))))
;witness2: "ke9849J-8-9"
(define-fun Witness2 () String (str.++ "k" (str.++ "e" (str.++ "9" (str.++ "8" (str.++ "4" (str.++ "9" (str.++ "J" (str.++ "-" (str.++ "8" (str.++ "-" (str.++ "9" ""))))))))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.range "-" "-") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.* (re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.* (re.++ (re.range "-" "-") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
