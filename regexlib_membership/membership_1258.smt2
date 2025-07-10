;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "y-2@k.RtmR"
(define-fun Witness1 () String (str.++ "y" (str.++ "-" (str.++ "2" (str.++ "@" (str.++ "k" (str.++ "." (str.++ "R" (str.++ "t" (str.++ "m" (str.++ "R" "")))))))))))
;witness2: "8.14@X0.hA"
(define-fun Witness2 () String (str.++ "8" (str.++ "." (str.++ "1" (str.++ "4" (str.++ "@" (str.++ "X" (str.++ "0" (str.++ "." (str.++ "h" (str.++ "A" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.opt (re.union (re.range "-" ".") (re.range "_" "_"))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.opt (re.range "-" ".")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.range "." ".")(re.++ (re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.* (re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
