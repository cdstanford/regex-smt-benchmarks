;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^ *([AaBbCcEeGgHhJjKkLlMmNnPpRrSsTtVvXxYy]\d[a-zA-Z]) *-* *(\d[a-zA-Z]\d) *$|^ *(\d{5}) *$|^ *(\d{5}) *-* *(\d{4}) *$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Y8T 9P0     "
(define-fun Witness1 () String (seq.++ "Y" (seq.++ "8" (seq.++ "T" (seq.++ " " (seq.++ "9" (seq.++ "P" (seq.++ "0" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " "")))))))))))))
;witness2: "22128  "
(define-fun Witness2 () String (seq.++ "2" (seq.++ "2" (seq.++ "1" (seq.++ "2" (seq.++ "8" (seq.++ " " (seq.++ " " ""))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.* (re.range " " " "))(re.++ (re.++ (re.union (re.range "A" "C")(re.union (re.range "E" "E")(re.union (re.range "G" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "T")(re.union (re.range "V" "V")(re.union (re.range "X" "Y")(re.union (re.range "a" "c")(re.union (re.range "e" "e")(re.union (re.range "g" "h")(re.union (re.range "j" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "t")(re.union (re.range "v" "v") (re.range "x" "y"))))))))))))))))(re.++ (re.range "0" "9") (re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.range " " " "))(re.++ (re.* (re.range "-" "-"))(re.++ (re.* (re.range " " " "))(re.++ (re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range "0" "9")))(re.++ (re.* (re.range " " " ")) (str.to_re "")))))))))(re.union (re.++ (str.to_re "")(re.++ (re.* (re.range " " " "))(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.* (re.range " " " ")) (str.to_re ""))))) (re.++ (str.to_re "")(re.++ (re.* (re.range " " " "))(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.* (re.range " " " "))(re.++ (re.* (re.range "-" "-"))(re.++ (re.* (re.range " " " "))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.* (re.range " " " ")) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
