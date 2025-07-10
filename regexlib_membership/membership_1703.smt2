;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-z0-9]+([\-a-z0-9]*[a-z0-9]+)?\.){0,}([a-z0-9]+([\-a-z0-9]*[a-z0-9]+)?){1,63}(\.[a-z0-9]{2,7})+$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "pefs1.fh--w5-t.zm.50xk86.5t0g4vz-l--9.1a.8c"
(define-fun Witness1 () String (str.++ "p" (str.++ "e" (str.++ "f" (str.++ "s" (str.++ "1" (str.++ "." (str.++ "f" (str.++ "h" (str.++ "-" (str.++ "-" (str.++ "w" (str.++ "5" (str.++ "-" (str.++ "t" (str.++ "." (str.++ "z" (str.++ "m" (str.++ "." (str.++ "5" (str.++ "0" (str.++ "x" (str.++ "k" (str.++ "8" (str.++ "6" (str.++ "." (str.++ "5" (str.++ "t" (str.++ "0" (str.++ "g" (str.++ "4" (str.++ "v" (str.++ "z" (str.++ "-" (str.++ "l" (str.++ "-" (str.++ "-" (str.++ "9" (str.++ "." (str.++ "1" (str.++ "a" (str.++ "." (str.++ "8" (str.++ "c" ""))))))))))))))))))))))))))))))))))))))))))))
;witness2: "99v988.8hz99.tdd.8z8ofkvxlzgwa.z6.u8"
(define-fun Witness2 () String (str.++ "9" (str.++ "9" (str.++ "v" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "h" (str.++ "z" (str.++ "9" (str.++ "9" (str.++ "." (str.++ "t" (str.++ "d" (str.++ "d" (str.++ "." (str.++ "8" (str.++ "z" (str.++ "8" (str.++ "o" (str.++ "f" (str.++ "k" (str.++ "v" (str.++ "x" (str.++ "l" (str.++ "z" (str.++ "g" (str.++ "w" (str.++ "a" (str.++ "." (str.++ "z" (str.++ "6" (str.++ "." (str.++ "u" (str.++ "8" "")))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))))) (re.range "." "."))))(re.++ ((_ re.loop 1 63) (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.+ (re.union (re.range "0" "9") (re.range "a" "z")))))))(re.++ (re.+ (re.++ (re.range "." ".") ((_ re.loop 2 7) (re.union (re.range "0" "9") (re.range "a" "z"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
