;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-zA-Z0-9]+([\-])?[a-zA-Z0-9]+)+(\.)?)+[a-zA-Z]{2,6}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "s1O-C.kXZ"
(define-fun Witness1 () String (str.++ "s" (str.++ "1" (str.++ "O" (str.++ "-" (str.++ "C" (str.++ "." (str.++ "k" (str.++ "X" (str.++ "Z" ""))))))))))
;witness2: "28-467tzn9zZLxXX"
(define-fun Witness2 () String (str.++ "2" (str.++ "8" (str.++ "-" (str.++ "4" (str.++ "6" (str.++ "7" (str.++ "t" (str.++ "z" (str.++ "n" (str.++ "9" (str.++ "z" (str.++ "Z" (str.++ "L" (str.++ "x" (str.++ "X" (str.++ "X" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.+ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.opt (re.range "-" "-")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))) (re.opt (re.range "." "."))))(re.++ ((_ re.loop 2 6) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
