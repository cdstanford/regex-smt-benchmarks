;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-zA-Z0-9]+([\-])?[a-zA-Z0-9]+)+(\.)?)+[a-zA-Z]{2,6}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "s1O-C.kXZ"
(define-fun Witness1 () String (seq.++ "s" (seq.++ "1" (seq.++ "O" (seq.++ "-" (seq.++ "C" (seq.++ "." (seq.++ "k" (seq.++ "X" (seq.++ "Z" ""))))))))))
;witness2: "28-467tzn9zZLxXX"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "8" (seq.++ "-" (seq.++ "4" (seq.++ "6" (seq.++ "7" (seq.++ "t" (seq.++ "z" (seq.++ "n" (seq.++ "9" (seq.++ "z" (seq.++ "Z" (seq.++ "L" (seq.++ "x" (seq.++ "X" (seq.++ "X" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.+ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.opt (re.range "-" "-")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))) (re.opt (re.range "." "."))))(re.++ ((_ re.loop 2 6) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
