;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-z][0-9])|([0-9][a-z])|([a-z0-9][a-z0-9\-]{1,2}[a-z0-9])|([a-z0-9][a-z0-9\-](([a-z0-9\-][a-z0-9])|([a-z0-9][a-z0-9\-]))[a-z0-9\-]*[a-z0-9]))\.(co|me|org|ltd|plc|net|sch|ac|mod|nhs|police|gov)\.uk$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "r-b4sz.ac.uk"
(define-fun Witness1 () String (seq.++ "r" (seq.++ "-" (seq.++ "b" (seq.++ "4" (seq.++ "s" (seq.++ "z" (seq.++ "." (seq.++ "a" (seq.++ "c" (seq.++ "." (seq.++ "u" (seq.++ "k" "")))))))))))))
;witness2: "ix3or.ac.uk"
(define-fun Witness2 () String (seq.++ "i" (seq.++ "x" (seq.++ "3" (seq.++ "o" (seq.++ "r" (seq.++ "." (seq.++ "a" (seq.++ "c" (seq.++ "." (seq.++ "u" (seq.++ "k" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "a" "z") (re.range "0" "9"))(re.union (re.++ (re.range "0" "9") (re.range "a" "z"))(re.union (re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ ((_ re.loop 1 2) (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z")))) (re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))(re.++ (re.union (re.++ (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))) (re.union (re.range "0" "9") (re.range "a" "z"))) (re.++ (re.union (re.range "0" "9") (re.range "a" "z")) (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z")))))))))(re.++ (re.range "." ".")(re.++ (re.union (str.to_re (seq.++ "c" (seq.++ "o" "")))(re.union (str.to_re (seq.++ "m" (seq.++ "e" "")))(re.union (str.to_re (seq.++ "o" (seq.++ "r" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "l" (seq.++ "t" (seq.++ "d" ""))))(re.union (str.to_re (seq.++ "p" (seq.++ "l" (seq.++ "c" ""))))(re.union (str.to_re (seq.++ "n" (seq.++ "e" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "s" (seq.++ "c" (seq.++ "h" ""))))(re.union (str.to_re (seq.++ "a" (seq.++ "c" "")))(re.union (str.to_re (seq.++ "m" (seq.++ "o" (seq.++ "d" ""))))(re.union (str.to_re (seq.++ "n" (seq.++ "h" (seq.++ "s" ""))))(re.union (str.to_re (seq.++ "p" (seq.++ "o" (seq.++ "l" (seq.++ "i" (seq.++ "c" (seq.++ "e" ""))))))) (str.to_re (seq.++ "g" (seq.++ "o" (seq.++ "v" "")))))))))))))))(re.++ (str.to_re (seq.++ "." (seq.++ "u" (seq.++ "k" "")))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
