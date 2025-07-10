;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[ABCEGHJKLMNPRSTVXYabceghjklmnprstvxy]{1}\d{1}[A-Za-z]{1}\d{1}[A-Za-z]{1}\d{1}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "R4o9j9"
(define-fun Witness1 () String (str.++ "R" (str.++ "4" (str.++ "o" (str.++ "9" (str.++ "j" (str.++ "9" "")))))))
;witness2: "c5E8C1"
(define-fun Witness2 () String (str.++ "c" (str.++ "5" (str.++ "E" (str.++ "8" (str.++ "C" (str.++ "1" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "C")(re.union (re.range "E" "E")(re.union (re.range "G" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "T")(re.union (re.range "V" "V")(re.union (re.range "X" "Y")(re.union (re.range "a" "c")(re.union (re.range "e" "e")(re.union (re.range "g" "h")(re.union (re.range "j" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "t")(re.union (re.range "v" "v") (re.range "x" "y"))))))))))))))))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range "0" "9") (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
