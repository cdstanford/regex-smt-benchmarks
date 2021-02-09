;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-z0-9]+([\-a-z0-9]*[a-z0-9]+)?\.){0,}([a-z0-9]+([\-a-z0-9]*[a-z0-9]+)?){1,63}(\.[a-z0-9]{2,7})+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "pefs1.fh--w5-t.zm.50xk86.5t0g4vz-l--9.1a.8c"
(define-fun Witness1 () String (seq.++ "p" (seq.++ "e" (seq.++ "f" (seq.++ "s" (seq.++ "1" (seq.++ "." (seq.++ "f" (seq.++ "h" (seq.++ "-" (seq.++ "-" (seq.++ "w" (seq.++ "5" (seq.++ "-" (seq.++ "t" (seq.++ "." (seq.++ "z" (seq.++ "m" (seq.++ "." (seq.++ "5" (seq.++ "0" (seq.++ "x" (seq.++ "k" (seq.++ "8" (seq.++ "6" (seq.++ "." (seq.++ "5" (seq.++ "t" (seq.++ "0" (seq.++ "g" (seq.++ "4" (seq.++ "v" (seq.++ "z" (seq.++ "-" (seq.++ "l" (seq.++ "-" (seq.++ "-" (seq.++ "9" (seq.++ "." (seq.++ "1" (seq.++ "a" (seq.++ "." (seq.++ "8" (seq.++ "c" ""))))))))))))))))))))))))))))))))))))))))))))
;witness2: "99v988.8hz99.tdd.8z8ofkvxlzgwa.z6.u8"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "9" (seq.++ "v" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "." (seq.++ "8" (seq.++ "h" (seq.++ "z" (seq.++ "9" (seq.++ "9" (seq.++ "." (seq.++ "t" (seq.++ "d" (seq.++ "d" (seq.++ "." (seq.++ "8" (seq.++ "z" (seq.++ "8" (seq.++ "o" (seq.++ "f" (seq.++ "k" (seq.++ "v" (seq.++ "x" (seq.++ "l" (seq.++ "z" (seq.++ "g" (seq.++ "w" (seq.++ "a" (seq.++ "." (seq.++ "z" (seq.++ "6" (seq.++ "." (seq.++ "u" (seq.++ "8" "")))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))))) (re.range "." "."))))(re.++ ((_ re.loop 1 63) (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.+ (re.union (re.range "0" "9") (re.range "a" "z")))))))(re.++ (re.+ (re.++ (re.range "." ".") ((_ re.loop 2 7) (re.union (re.range "0" "9") (re.range "a" "z"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
