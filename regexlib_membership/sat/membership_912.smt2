;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((\(\d{3}\)|\d{3})( |-|\.))|(\(\d{3}\)|\d{3}))?\d{3}( |-|\.)?\d{4}(( |-|\.)?([Ee]xt|[Xx])[.]?( |-|\.)?\d{4})?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "999 991 9789"
(define-fun Witness1 () String (str.++ "9" (str.++ "9" (str.++ "9" (str.++ " " (str.++ "9" (str.++ "9" (str.++ "1" (str.++ " " (str.++ "9" (str.++ "7" (str.++ "8" (str.++ "9" "")))))))))))))
;witness2: "(588)2989488"
(define-fun Witness2 () String (str.++ "(" (str.++ "5" (str.++ "8" (str.++ "8" (str.++ ")" (str.++ "2" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "4" (str.++ "8" (str.++ "8" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.++ (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range ")" ")"))) ((_ re.loop 3 3) (re.range "0" "9"))) (re.union (re.range " " " ") (re.range "-" "."))) (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range ")" ")"))) ((_ re.loop 3 3) (re.range "0" "9")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" ".")))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.opt (re.union (re.range " " " ") (re.range "-" ".")))(re.++ (re.union (re.++ (re.union (re.range "E" "E") (re.range "e" "e")) (str.to_re (str.++ "x" (str.++ "t" "")))) (re.union (re.range "X" "X") (re.range "x" "x")))(re.++ (re.opt (re.range "." "."))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "."))) ((_ re.loop 4 4) (re.range "0" "9"))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
