;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((?:(?:(?:[a-zA-Z0-9][\.\-\+_]?)*)[a-zA-Z0-9])+)\@((?:(?:(?:[a-zA-Z0-9][\.\-_]?){0,62})[a-zA-Z0-9])+)\.([a-zA-Z0-9]{2,6})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "zY@9_t7_P.92_8.8XZz2"
(define-fun Witness1 () String (str.++ "z" (str.++ "Y" (str.++ "@" (str.++ "9" (str.++ "_" (str.++ "t" (str.++ "7" (str.++ "_" (str.++ "P" (str.++ "." (str.++ "9" (str.++ "2" (str.++ "_" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "X" (str.++ "Z" (str.++ "z" (str.++ "2" "")))))))))))))))))))))
;witness2: "v@48.83"
(define-fun Witness2 () String (str.++ "v" (str.++ "@" (str.++ "4" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "3" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.* (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.union (re.range "+" "+")(re.union (re.range "-" ".") (re.range "_" "_")))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ ((_ re.loop 0 62) (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.union (re.range "-" ".") (re.range "_" "_"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 6) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
