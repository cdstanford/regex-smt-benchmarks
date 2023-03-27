;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z0-9]+[._-])*[a-zA-Z0-9]+@(([a-zA-Z0-9]+|([a-zA-Z0-9]+[.-])+)[a-zA-Z0-9]+\.[a-zA-Z]{2,4}|([a-zA-Z]\.com))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1F4@Q0-L88.59.SZxZ"
(define-fun Witness1 () String (str.++ "1" (str.++ "F" (str.++ "4" (str.++ "@" (str.++ "Q" (str.++ "0" (str.++ "-" (str.++ "L" (str.++ "8" (str.++ "8" (str.++ "." (str.++ "5" (str.++ "9" (str.++ "." (str.++ "S" (str.++ "Z" (str.++ "x" (str.++ "Z" "")))))))))))))))))))
;witness2: "t8_9s9AA@c78Z-tZ-89.Qb"
(define-fun Witness2 () String (str.++ "t" (str.++ "8" (str.++ "_" (str.++ "9" (str.++ "s" (str.++ "9" (str.++ "A" (str.++ "A" (str.++ "@" (str.++ "c" (str.++ "7" (str.++ "8" (str.++ "Z" (str.++ "-" (str.++ "t" (str.++ "Z" (str.++ "-" (str.++ "8" (str.++ "9" (str.++ "." (str.++ "Q" (str.++ "b" "")))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.union (re.range "-" ".") (re.range "_" "_"))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "@" "@")(re.++ (re.union (re.++ (re.union (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.+ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.range "-" "."))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "." ".") ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (str.to_re (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" ""))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
