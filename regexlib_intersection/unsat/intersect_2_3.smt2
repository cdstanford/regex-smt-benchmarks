;---
; using 8-bit bit-vectors as characters
; check intersection nonemptiness of .Net regexes
; regexA = ^([A-Z]{2}|[a-z]{2} \d{2} [A-Z]{1,2}|[a-z]{1,2} \d{1,4})?([A-Z]{3}|[a-z]{3} \d{1,4})?\z
; regexB = ^([A-Z]|[a-z]|[0-9])(((\.|\-)?([A-Z]|[a-z]|[0-9])+)*)@(([A-Z]|[a-z]|[0-9])+)(((\.|\-)?([A-Z]|[a-z]|[0-9])+)*)\. (([A-Z]|[a-z])([A-Z]|[a-z])+)\z
;---
;(set-info :status unsat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const regexB RegLan)
(declare-const x String)

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union ((_ re.loop 2 2) (re.range "A" "Z"))(re.union (re.++ ((_ re.loop 2 2) (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 1 2) (re.range "A" "Z")))))) (re.++ ((_ re.loop 1 2) (re.range "a" "z"))(re.++ (re.range " " " ") ((_ re.loop 1 4) (re.range "0" "9")))))))(re.++ (re.opt (re.union ((_ re.loop 3 3) (re.range "A" "Z")) (re.++ ((_ re.loop 3 3) (re.range "a" "z"))(re.++ (re.range " " " ") ((_ re.loop 1 4) (re.range "0" "9")))))) (str.to_re ""))))))

(assert (= regexB (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.opt (re.range "-" ".")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.opt (re.range "-" ".")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (str.to_re (str.++ "." (str.++ " " "")))(re.++ (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "")))))))))))

;check that the intersection is nonempty, contains some x
(assert (str.in_re x regexA))
(assert (str.in_re x regexB))
(check-sat)
