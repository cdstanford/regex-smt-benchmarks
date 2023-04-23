;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-h,A-H,j-n,J-N,p-z,P-Z,0-9]{9})([a-h,A-H,j-n,J-N,p,P,r-t,R-T,v-z,V-Z,0-9])([a-h,A-H,j-n,J-N,p-z,P-Z,0-9])(\d{6}))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "C0jl8M,18wz688399"
(define-fun Witness1 () String (str.++ "C" (str.++ "0" (str.++ "j" (str.++ "l" (str.++ "8" (str.++ "M" (str.++ "," (str.++ "1" (str.++ "8" (str.++ "w" (str.++ "z" (str.++ "6" (str.++ "8" (str.++ "8" (str.++ "3" (str.++ "9" (str.++ "9" ""))))))))))))))))))
;witness2: "1,,68,sh68,969819"
(define-fun Witness2 () String (str.++ "1" (str.++ "," (str.++ "," (str.++ "6" (str.++ "8" (str.++ "," (str.++ "s" (str.++ "h" (str.++ "6" (str.++ "8" (str.++ "," (str.++ "9" (str.++ "6" (str.++ "9" (str.++ "8" (str.++ "1" (str.++ "9" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 9 9) (re.union (re.range "," ",")(re.union (re.range "0" "9")(re.union (re.range "A" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "Z")(re.union (re.range "a" "h")(re.union (re.range "j" "n") (re.range "p" "z")))))))))(re.++ (re.union (re.range "," ",")(re.union (re.range "0" "9")(re.union (re.range "A" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "T")(re.union (re.range "V" "Z")(re.union (re.range "a" "h")(re.union (re.range "j" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "t") (re.range "v" "z"))))))))))))(re.++ (re.union (re.range "," ",")(re.union (re.range "0" "9")(re.union (re.range "A" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "Z")(re.union (re.range "a" "h")(re.union (re.range "j" "n") (re.range "p" "z")))))))) ((_ re.loop 6 6) (re.range "0" "9"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
