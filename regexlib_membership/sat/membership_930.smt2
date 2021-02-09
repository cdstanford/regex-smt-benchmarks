;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z,#/ \.\(\)\-\+\*]*[2-9])([a-zA-Z,#/ \.\(\)\-\+\*]*[0-9]){2}([a-zA-Z,#/ \.\(\)\-\+\*]*[2-9])([a-zA-Z,#/ \.\(\)\-\+\*]*[0-9]){6}[0-9a-zA-Z,#/ \.\(\)\-\+\*]*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "-#2982yE2,p11.1Q92"
(define-fun Witness1 () String (seq.++ "-" (seq.++ "#" (seq.++ "2" (seq.++ "9" (seq.++ "8" (seq.++ "2" (seq.++ "y" (seq.++ "E" (seq.++ "2" (seq.++ "," (seq.++ "p" (seq.++ "1" (seq.++ "1" (seq.++ "." (seq.++ "1" (seq.++ "Q" (seq.++ "9" (seq.++ "2" "")))))))))))))))))))
;witness2: "-5Q0##-  ,89918#8)+31c/9"
(define-fun Witness2 () String (seq.++ "-" (seq.++ "5" (seq.++ "Q" (seq.++ "0" (seq.++ "#" (seq.++ "#" (seq.++ "-" (seq.++ " " (seq.++ " " (seq.++ "," (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "1" (seq.++ "8" (seq.++ "#" (seq.++ "8" (seq.++ ")" (seq.++ "+" (seq.++ "3" (seq.++ "1" (seq.++ "c" (seq.++ "/" (seq.++ "9" "")))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "(" "/")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.range "2" "9"))(re.++ ((_ re.loop 2 2) (re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "(" "/")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.range "0" "9")))(re.++ (re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "(" "/")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.range "2" "9"))(re.++ ((_ re.loop 6 6) (re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "(" "/")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.range "0" "9")))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "(" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
