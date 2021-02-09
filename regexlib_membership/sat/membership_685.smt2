;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([0-9])|([0-2][0-9])|([3][0-1]))\/(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\/\d{4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "6/Jan/7889"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "/" (seq.++ "J" (seq.++ "a" (seq.++ "n" (seq.++ "/" (seq.++ "7" (seq.++ "8" (seq.++ "8" (seq.++ "9" "")))))))))))
;witness2: "29/Sep/9288"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "9" (seq.++ "/" (seq.++ "S" (seq.++ "e" (seq.++ "p" (seq.++ "/" (seq.++ "9" (seq.++ "2" (seq.++ "8" (seq.++ "8" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range "/" "/")(re.++ (re.union (str.to_re (seq.++ "J" (seq.++ "a" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "F" (seq.++ "e" (seq.++ "b" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "a" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "p" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "a" (seq.++ "y" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "u" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "u" (seq.++ "l" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "u" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "S" (seq.++ "e" (seq.++ "p" ""))))(re.union (str.to_re (seq.++ "O" (seq.++ "c" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "N" (seq.++ "o" (seq.++ "v" "")))) (str.to_re (seq.++ "D" (seq.++ "e" (seq.++ "c" "")))))))))))))))(re.++ (re.range "/" "/")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
