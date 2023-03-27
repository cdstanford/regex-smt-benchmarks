;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((A[LKSZR])|(C[AOT])|(D[EC])|(F[ML])|(G[AU])|(HI)|(I[DLNA])|(K[SY])|(LA)|(M[EHDAINSOT])|(N[EVHJMYCD])|(MP)|(O[HKR])|(P[WAR])|(RI)|(S[CD])|(T[NX])|(UT)|(V[TIA])|(W[AVIY]))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "TX"
(define-fun Witness1 () String (str.++ "T" (str.++ "X" "")))
;witness2: "OH"
(define-fun Witness2 () String (str.++ "O" (str.++ "H" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "A" "A") (re.union (re.range "K" "L")(re.union (re.range "R" "S") (re.range "Z" "Z"))))(re.union (re.++ (re.range "C" "C") (re.union (re.range "A" "A")(re.union (re.range "O" "O") (re.range "T" "T"))))(re.union (re.++ (re.range "D" "D") (re.union (re.range "C" "C") (re.range "E" "E")))(re.union (re.++ (re.range "F" "F") (re.range "L" "M"))(re.union (re.++ (re.range "G" "G") (re.union (re.range "A" "A") (re.range "U" "U")))(re.union (str.to_re (str.++ "H" (str.++ "I" "")))(re.union (re.++ (re.range "I" "I") (re.union (re.range "A" "A")(re.union (re.range "D" "D")(re.union (re.range "L" "L") (re.range "N" "N")))))(re.union (re.++ (re.range "K" "K") (re.union (re.range "S" "S") (re.range "Y" "Y")))(re.union (str.to_re (str.++ "L" (str.++ "A" "")))(re.union (re.++ (re.range "M" "M") (re.union (re.range "A" "A")(re.union (re.range "D" "E")(re.union (re.range "H" "I")(re.union (re.range "N" "O") (re.range "S" "T"))))))(re.union (re.++ (re.range "N" "N") (re.union (re.range "C" "E")(re.union (re.range "H" "H")(re.union (re.range "J" "J")(re.union (re.range "M" "M")(re.union (re.range "V" "V") (re.range "Y" "Y")))))))(re.union (str.to_re (str.++ "M" (str.++ "P" "")))(re.union (re.++ (re.range "O" "O") (re.union (re.range "H" "H")(re.union (re.range "K" "K") (re.range "R" "R"))))(re.union (re.++ (re.range "P" "P") (re.union (re.range "A" "A")(re.union (re.range "R" "R") (re.range "W" "W"))))(re.union (str.to_re (str.++ "R" (str.++ "I" "")))(re.union (re.++ (re.range "S" "S") (re.range "C" "D"))(re.union (re.++ (re.range "T" "T") (re.union (re.range "N" "N") (re.range "X" "X")))(re.union (str.to_re (str.++ "U" (str.++ "T" "")))(re.union (re.++ (re.range "V" "V") (re.union (re.range "A" "A")(re.union (re.range "I" "I") (re.range "T" "T")))) (re.++ (re.range "W" "W") (re.union (re.range "A" "A")(re.union (re.range "I" "I")(re.union (re.range "V" "V") (re.range "Y" "Y")))))))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
