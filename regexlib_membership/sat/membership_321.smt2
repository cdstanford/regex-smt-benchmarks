;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z0-9]+[._-])*[a-zA-Z0-9]+@(([a-zA-Z0-9]+|([a-zA-Z0-9]+[.-])+)[a-zA-Z0-9]+\.[a-zA-Z]{2,4}|([a-zA-Z]\.com))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1F4@Q0-L88.59.SZxZ"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "F" (seq.++ "4" (seq.++ "@" (seq.++ "Q" (seq.++ "0" (seq.++ "-" (seq.++ "L" (seq.++ "8" (seq.++ "8" (seq.++ "." (seq.++ "5" (seq.++ "9" (seq.++ "." (seq.++ "S" (seq.++ "Z" (seq.++ "x" (seq.++ "Z" "")))))))))))))))))))
;witness2: "t8_9s9AA@c78Z-tZ-89.Qb"
(define-fun Witness2 () String (seq.++ "t" (seq.++ "8" (seq.++ "_" (seq.++ "9" (seq.++ "s" (seq.++ "9" (seq.++ "A" (seq.++ "A" (seq.++ "@" (seq.++ "c" (seq.++ "7" (seq.++ "8" (seq.++ "Z" (seq.++ "-" (seq.++ "t" (seq.++ "Z" (seq.++ "-" (seq.++ "8" (seq.++ "9" (seq.++ "." (seq.++ "Q" (seq.++ "b" "")))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.union (re.range "-" ".") (re.range "_" "_"))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "@" "@")(re.++ (re.union (re.++ (re.union (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.+ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.range "-" "."))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "." ".") ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (str.to_re (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" ""))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
