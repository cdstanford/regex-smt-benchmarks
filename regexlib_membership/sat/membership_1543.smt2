;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-h,A-H,j-n,J-N,p-z,P-Z,0-9]{9})([a-h,A-H,j-n,J-N,p,P,r-t,R-T,v-z,V-Z,0-9])([a-h,A-H,j-n,J-N,p-z,P-Z,0-9])(\d{6}))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "C0jl8M,18wz688399"
(define-fun Witness1 () String (seq.++ "C" (seq.++ "0" (seq.++ "j" (seq.++ "l" (seq.++ "8" (seq.++ "M" (seq.++ "," (seq.++ "1" (seq.++ "8" (seq.++ "w" (seq.++ "z" (seq.++ "6" (seq.++ "8" (seq.++ "8" (seq.++ "3" (seq.++ "9" (seq.++ "9" ""))))))))))))))))))
;witness2: "1,,68,sh68,969819"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "," (seq.++ "," (seq.++ "6" (seq.++ "8" (seq.++ "," (seq.++ "s" (seq.++ "h" (seq.++ "6" (seq.++ "8" (seq.++ "," (seq.++ "9" (seq.++ "6" (seq.++ "9" (seq.++ "8" (seq.++ "1" (seq.++ "9" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 9 9) (re.union (re.range "," ",")(re.union (re.range "0" "9")(re.union (re.range "A" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "Z")(re.union (re.range "a" "h")(re.union (re.range "j" "n") (re.range "p" "z")))))))))(re.++ (re.union (re.range "," ",")(re.union (re.range "0" "9")(re.union (re.range "A" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "T")(re.union (re.range "V" "Z")(re.union (re.range "a" "h")(re.union (re.range "j" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "t") (re.range "v" "z"))))))))))))(re.++ (re.union (re.range "," ",")(re.union (re.range "0" "9")(re.union (re.range "A" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "Z")(re.union (re.range "a" "h")(re.union (re.range "j" "n") (re.range "p" "z")))))))) ((_ re.loop 6 6) (re.range "0" "9"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
