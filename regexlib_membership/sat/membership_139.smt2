;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "S6K9N4"
(define-fun Witness1 () String (seq.++ "S" (seq.++ "6" (seq.++ "K" (seq.++ "9" (seq.++ "N" (seq.++ "4" "")))))))
;witness2: "X8Y9F8"
(define-fun Witness2 () String (seq.++ "X" (seq.++ "8" (seq.++ "Y" (seq.++ "9" (seq.++ "F" (seq.++ "8" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "C")(re.union (re.range "E" "E")(re.union (re.range "G" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "T")(re.union (re.range "V" "V") (re.range "X" "Y"))))))))(re.++ (re.range "0" "9")(re.++ (re.range "A" "Z")(re.++ (re.* (re.range " " " "))(re.++ (re.range "0" "9")(re.++ (re.range "A" "Z")(re.++ (re.range "0" "9") (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
