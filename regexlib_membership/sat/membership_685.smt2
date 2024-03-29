;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([0-9])|([0-2][0-9])|([3][0-1]))\/(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\/\d{4}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "6/Jan/7889"
(define-fun Witness1 () String (str.++ "6" (str.++ "/" (str.++ "J" (str.++ "a" (str.++ "n" (str.++ "/" (str.++ "7" (str.++ "8" (str.++ "8" (str.++ "9" "")))))))))))
;witness2: "29/Sep/9288"
(define-fun Witness2 () String (str.++ "2" (str.++ "9" (str.++ "/" (str.++ "S" (str.++ "e" (str.++ "p" (str.++ "/" (str.++ "9" (str.++ "2" (str.++ "8" (str.++ "8" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range "/" "/")(re.++ (re.union (str.to_re (str.++ "J" (str.++ "a" (str.++ "n" ""))))(re.union (str.to_re (str.++ "F" (str.++ "e" (str.++ "b" ""))))(re.union (str.to_re (str.++ "M" (str.++ "a" (str.++ "r" ""))))(re.union (str.to_re (str.++ "A" (str.++ "p" (str.++ "r" ""))))(re.union (str.to_re (str.++ "M" (str.++ "a" (str.++ "y" ""))))(re.union (str.to_re (str.++ "J" (str.++ "u" (str.++ "n" ""))))(re.union (str.to_re (str.++ "J" (str.++ "u" (str.++ "l" ""))))(re.union (str.to_re (str.++ "A" (str.++ "u" (str.++ "g" ""))))(re.union (str.to_re (str.++ "S" (str.++ "e" (str.++ "p" ""))))(re.union (str.to_re (str.++ "O" (str.++ "c" (str.++ "t" ""))))(re.union (str.to_re (str.++ "N" (str.++ "o" (str.++ "v" "")))) (str.to_re (str.++ "D" (str.++ "e" (str.++ "c" "")))))))))))))))(re.++ (re.range "/" "/")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
