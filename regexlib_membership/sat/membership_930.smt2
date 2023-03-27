;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z,#/ \.\(\)\-\+\*]*[2-9])([a-zA-Z,#/ \.\(\)\-\+\*]*[0-9]){2}([a-zA-Z,#/ \.\(\)\-\+\*]*[2-9])([a-zA-Z,#/ \.\(\)\-\+\*]*[0-9]){6}[0-9a-zA-Z,#/ \.\(\)\-\+\*]*$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-#2982yE2,p11.1Q92"
(define-fun Witness1 () String (str.++ "-" (str.++ "#" (str.++ "2" (str.++ "9" (str.++ "8" (str.++ "2" (str.++ "y" (str.++ "E" (str.++ "2" (str.++ "," (str.++ "p" (str.++ "1" (str.++ "1" (str.++ "." (str.++ "1" (str.++ "Q" (str.++ "9" (str.++ "2" "")))))))))))))))))))
;witness2: "-5Q0##-  ,89918#8)+31c/9"
(define-fun Witness2 () String (str.++ "-" (str.++ "5" (str.++ "Q" (str.++ "0" (str.++ "#" (str.++ "#" (str.++ "-" (str.++ " " (str.++ " " (str.++ "," (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "1" (str.++ "8" (str.++ "#" (str.++ "8" (str.++ ")" (str.++ "+" (str.++ "3" (str.++ "1" (str.++ "c" (str.++ "/" (str.++ "9" "")))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "(" "/")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.range "2" "9"))(re.++ ((_ re.loop 2 2) (re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "(" "/")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.range "0" "9")))(re.++ (re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "(" "/")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.range "2" "9"))(re.++ ((_ re.loop 6 6) (re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "(" "/")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.range "0" "9")))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "(" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
