;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-z][0-9])|([0-9][a-z])|([a-z0-9][a-z0-9\-]{1,2}[a-z0-9])|([a-z0-9][a-z0-9\-](([a-z0-9\-][a-z0-9])|([a-z0-9][a-z0-9\-]))[a-z0-9\-]*[a-z0-9]))\.(co|me|org|ltd|plc|net|sch|ac|mod|nhs|police|gov)\.uk$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "r-b4sz.ac.uk"
(define-fun Witness1 () String (str.++ "r" (str.++ "-" (str.++ "b" (str.++ "4" (str.++ "s" (str.++ "z" (str.++ "." (str.++ "a" (str.++ "c" (str.++ "." (str.++ "u" (str.++ "k" "")))))))))))))
;witness2: "ix3or.ac.uk"
(define-fun Witness2 () String (str.++ "i" (str.++ "x" (str.++ "3" (str.++ "o" (str.++ "r" (str.++ "." (str.++ "a" (str.++ "c" (str.++ "." (str.++ "u" (str.++ "k" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "a" "z") (re.range "0" "9"))(re.union (re.++ (re.range "0" "9") (re.range "a" "z"))(re.union (re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ ((_ re.loop 1 2) (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z")))) (re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))(re.++ (re.union (re.++ (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))) (re.union (re.range "0" "9") (re.range "a" "z"))) (re.++ (re.union (re.range "0" "9") (re.range "a" "z")) (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z")))))))))(re.++ (re.range "." ".")(re.++ (re.union (str.to_re (str.++ "c" (str.++ "o" "")))(re.union (str.to_re (str.++ "m" (str.++ "e" "")))(re.union (str.to_re (str.++ "o" (str.++ "r" (str.++ "g" ""))))(re.union (str.to_re (str.++ "l" (str.++ "t" (str.++ "d" ""))))(re.union (str.to_re (str.++ "p" (str.++ "l" (str.++ "c" ""))))(re.union (str.to_re (str.++ "n" (str.++ "e" (str.++ "t" ""))))(re.union (str.to_re (str.++ "s" (str.++ "c" (str.++ "h" ""))))(re.union (str.to_re (str.++ "a" (str.++ "c" "")))(re.union (str.to_re (str.++ "m" (str.++ "o" (str.++ "d" ""))))(re.union (str.to_re (str.++ "n" (str.++ "h" (str.++ "s" ""))))(re.union (str.to_re (str.++ "p" (str.++ "o" (str.++ "l" (str.++ "i" (str.++ "c" (str.++ "e" ""))))))) (str.to_re (str.++ "g" (str.++ "o" (str.++ "v" "")))))))))))))))(re.++ (str.to_re (str.++ "." (str.++ "u" (str.++ "k" "")))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
