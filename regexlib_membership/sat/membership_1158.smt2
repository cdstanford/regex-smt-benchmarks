;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((A[ABEHKLMPRSTWXYZ])|(B[ABEHKLMT])|(C[ABEHKLR])|(E[ABEHKLMPRSTWXYZ])|(GY)|(H[ABEHKLMPRSTWXYZ])|(J[ABCEGHJKLMNPRSTWXYZ])|(K[ABEHKLMPRSTWXYZ])|(L[ABEHKLMPRSTWXYZ])|(M[AWX])|(N[ABEHLMPRSWXYZ])|(O[ABEHKLMPRSX])|(P[ABCEGHJLMNPRSTWXY])|(R[ABEHKMPRSTWXYZ])|(S[ABCGHJKLMNPRSTWXYZ])|(T[ABEHKLMPRSTWXYZ])|(W[ABEKLMP])|(Y[ABEHKLMPRSTWXYZ])|(Z[ABEHKLMPRSTWXY]))\d{6}([A-D]|\s)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "PW978832\u0085"
(define-fun Witness1 () String (str.++ "P" (str.++ "W" (str.++ "9" (str.++ "7" (str.++ "8" (str.++ "8" (str.++ "3" (str.++ "2" (str.++ "\u{85}" ""))))))))))
;witness2: "BT190834D"
(define-fun Witness2 () String (str.++ "B" (str.++ "T" (str.++ "1" (str.++ "9" (str.++ "0" (str.++ "8" (str.++ "3" (str.++ "4" (str.++ "D" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "A" "A") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "K" "M")(re.union (re.range "P" "P")(re.union (re.range "R" "T") (re.range "W" "Z"))))))))(re.union (re.++ (re.range "B" "B") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "K" "M") (re.range "T" "T"))))))(re.union (re.++ (re.range "C" "C") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "K" "L") (re.range "R" "R"))))))(re.union (re.++ (re.range "E" "E") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "K" "M")(re.union (re.range "P" "P")(re.union (re.range "R" "T") (re.range "W" "Z"))))))))(re.union (str.to_re (str.++ "G" (str.++ "Y" "")))(re.union (re.++ (re.range "H" "H") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "K" "M")(re.union (re.range "P" "P")(re.union (re.range "R" "T") (re.range "W" "Z"))))))))(re.union (re.++ (re.range "J" "J") (re.union (re.range "A" "C")(re.union (re.range "E" "E")(re.union (re.range "G" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "T") (re.range "W" "Z"))))))))(re.union (re.++ (re.range "K" "K") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "K" "M")(re.union (re.range "P" "P")(re.union (re.range "R" "T") (re.range "W" "Z"))))))))(re.union (re.++ (re.range "L" "L") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "K" "M")(re.union (re.range "P" "P")(re.union (re.range "R" "T") (re.range "W" "Z"))))))))(re.union (re.++ (re.range "M" "M") (re.union (re.range "A" "A") (re.range "W" "X")))(re.union (re.++ (re.range "N" "N") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "L" "M")(re.union (re.range "P" "P")(re.union (re.range "R" "S") (re.range "W" "Z"))))))))(re.union (re.++ (re.range "O" "O") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "K" "M")(re.union (re.range "P" "P")(re.union (re.range "R" "S") (re.range "X" "X"))))))))(re.union (re.++ (re.range "P" "P") (re.union (re.range "A" "C")(re.union (re.range "E" "E")(re.union (re.range "G" "H")(re.union (re.range "J" "J")(re.union (re.range "L" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "T") (re.range "W" "Y")))))))))(re.union (re.++ (re.range "R" "R") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "K" "K")(re.union (re.range "M" "M")(re.union (re.range "P" "P")(re.union (re.range "R" "T") (re.range "W" "Z")))))))))(re.union (re.++ (re.range "S" "S") (re.union (re.range "A" "C")(re.union (re.range "G" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "T") (re.range "W" "Z")))))))(re.union (re.++ (re.range "T" "T") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "K" "M")(re.union (re.range "P" "P")(re.union (re.range "R" "T") (re.range "W" "Z"))))))))(re.union (re.++ (re.range "W" "W") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "K" "M") (re.range "P" "P")))))(re.union (re.++ (re.range "Y" "Y") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "K" "M")(re.union (re.range "P" "P")(re.union (re.range "R" "T") (re.range "W" "Z")))))))) (re.++ (re.range "Z" "Z") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "K" "M")(re.union (re.range "P" "P")(re.union (re.range "R" "T") (re.range "W" "Y"))))))))))))))))))))))))))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "A" "D")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
