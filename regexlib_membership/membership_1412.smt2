;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-z0-9]{32})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1k656wz46ifg4xj84792ih8a4ze986z8"
(define-fun Witness1 () String (str.++ "1" (str.++ "k" (str.++ "6" (str.++ "5" (str.++ "6" (str.++ "w" (str.++ "z" (str.++ "4" (str.++ "6" (str.++ "i" (str.++ "f" (str.++ "g" (str.++ "4" (str.++ "x" (str.++ "j" (str.++ "8" (str.++ "4" (str.++ "7" (str.++ "9" (str.++ "2" (str.++ "i" (str.++ "h" (str.++ "8" (str.++ "a" (str.++ "4" (str.++ "z" (str.++ "e" (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "z" (str.++ "8" "")))))))))))))))))))))))))))))))))
;witness2: "zhhmvc2779zlj8avrq9pla3zb84i1b8q"
(define-fun Witness2 () String (str.++ "z" (str.++ "h" (str.++ "h" (str.++ "m" (str.++ "v" (str.++ "c" (str.++ "2" (str.++ "7" (str.++ "7" (str.++ "9" (str.++ "z" (str.++ "l" (str.++ "j" (str.++ "8" (str.++ "a" (str.++ "v" (str.++ "r" (str.++ "q" (str.++ "9" (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "3" (str.++ "z" (str.++ "b" (str.++ "8" (str.++ "4" (str.++ "i" (str.++ "1" (str.++ "b" (str.++ "8" (str.++ "q" "")))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 32 32) (re.union (re.range "0" "9") (re.range "a" "z"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
