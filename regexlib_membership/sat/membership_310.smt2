;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z0-9]+(([_][a-zA-Z0-9])?[a-zA-Z0-9]*)*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0_8U"
(define-fun Witness1 () String (str.++ "0" (str.++ "_" (str.++ "8" (str.++ "U" "")))))
;witness2: "494"
(define-fun Witness2 () String (str.++ "4" (str.++ "9" (str.++ "4" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.opt (re.++ (re.range "_" "_") (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
