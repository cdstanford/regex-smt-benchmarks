;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([ABCEGHJKLMNPRSTVXY]\d[ABCEGHJKLMNPRSTVWXYZ])\ {0,1}(\d[ABCEGHJKLMNPRSTVWXYZ]\d)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Y9Z1G9"
(define-fun Witness1 () String (str.++ "Y" (str.++ "9" (str.++ "Z" (str.++ "1" (str.++ "G" (str.++ "9" "")))))))
;witness2: "N9H2X4"
(define-fun Witness2 () String (str.++ "N" (str.++ "9" (str.++ "H" (str.++ "2" (str.++ "X" (str.++ "4" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "A" "C")(re.union (re.range "E" "E")(re.union (re.range "G" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "T")(re.union (re.range "V" "V") (re.range "X" "Y"))))))))(re.++ (re.range "0" "9") (re.union (re.range "A" "C")(re.union (re.range "E" "E")(re.union (re.range "G" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "T") (re.range "V" "Z")))))))))(re.++ (re.opt (re.range " " " "))(re.++ (re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "C")(re.union (re.range "E" "E")(re.union (re.range "G" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "T") (re.range "V" "Z"))))))) (re.range "0" "9"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
