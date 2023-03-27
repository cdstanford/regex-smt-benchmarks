;---
; using 8-bit bit-vectors as characters
; check if regexA is not a subset of regexB
; regexA = ^([A-Z]|[a-z]|[0-9])(((\.|\-)?([A-Z]|[a-z]|[0-9])+)*)@(([A-Z]|[a-z]|[0-9])+)(((\.|\-)?([A-Z]|[a-z]|[0-9])+)*)\. (([A-Z]|[a-z])([A-Z]|[a-z])+)\z
; regexB = ^\$?(\d{1,3},?(\d{3},?)*\d{3}(\.\d{0,2})?|\d{1,3}(\.\d{0,2})?|\.(\d{1,2})?)\z
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const regexB RegLan)
(declare-const x String)

;witness: "9@6. Az"
(define-fun Witness () String (str.++ "9" (str.++ "@" (str.++ "6" (str.++ "." (str.++ " " (str.++ "A" (str.++ "z" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.opt (re.range "-" ".")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.opt (re.range "-" ".")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (str.to_re (str.++ "." (str.++ " " "")))(re.++ (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "")))))))))))

(assert (= regexB (re.++ (str.to_re "")(re.++ (re.opt (re.range "$" "$"))(re.++ (re.union (re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.opt (re.range "," ","))(re.++ (re.* (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range "," ","))))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.++ (re.range "." ".") ((_ re.loop 0 2) (re.range "0" "9"))))))))(re.union (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.opt (re.++ (re.range "." ".") ((_ re.loop 0 2) (re.range "0" "9"))))) (re.++ (re.range "." ".") (re.opt ((_ re.loop 1 2) (re.range "0" "9")))))) (str.to_re ""))))))

;(assert (not (re-subset regexA regexB)))
;check that the difference is nonempty, contains some x
(assert (str.in_re x regexA))
(assert (not (str.in_re x regexB)))
;check also the concrete witness
(assert (str.in_re Witness regexA))
(assert (not (str.in_re Witness regexB)))
(check-sat)
