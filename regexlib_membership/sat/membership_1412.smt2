;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-z0-9]{32})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1k656wz46ifg4xj84792ih8a4ze986z8"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "k" (seq.++ "6" (seq.++ "5" (seq.++ "6" (seq.++ "w" (seq.++ "z" (seq.++ "4" (seq.++ "6" (seq.++ "i" (seq.++ "f" (seq.++ "g" (seq.++ "4" (seq.++ "x" (seq.++ "j" (seq.++ "8" (seq.++ "4" (seq.++ "7" (seq.++ "9" (seq.++ "2" (seq.++ "i" (seq.++ "h" (seq.++ "8" (seq.++ "a" (seq.++ "4" (seq.++ "z" (seq.++ "e" (seq.++ "9" (seq.++ "8" (seq.++ "6" (seq.++ "z" (seq.++ "8" "")))))))))))))))))))))))))))))))))
;witness2: "zhhmvc2779zlj8avrq9pla3zb84i1b8q"
(define-fun Witness2 () String (seq.++ "z" (seq.++ "h" (seq.++ "h" (seq.++ "m" (seq.++ "v" (seq.++ "c" (seq.++ "2" (seq.++ "7" (seq.++ "7" (seq.++ "9" (seq.++ "z" (seq.++ "l" (seq.++ "j" (seq.++ "8" (seq.++ "a" (seq.++ "v" (seq.++ "r" (seq.++ "q" (seq.++ "9" (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "3" (seq.++ "z" (seq.++ "b" (seq.++ "8" (seq.++ "4" (seq.++ "i" (seq.++ "1" (seq.++ "b" (seq.++ "8" (seq.++ "q" "")))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 32 32) (re.union (re.range "0" "9") (re.range "a" "z"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
