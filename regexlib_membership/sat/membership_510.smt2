;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((A[LKZR])|(C[AOT])|(D[EC])|(FL)|(GA)|(HI)|(I[DLNA])|(K[SY])|(LA)|(M[EDAINSOT])|(N[EVHJMYCD])|(O[HKR])|(PA)|(RI)|(S[CD])|(T[NX])|(UT)|(V[TA])|(W[AVIY]))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "DE"
(define-fun Witness1 () String (seq.++ "D" (seq.++ "E" "")))
;witness2: "AK"
(define-fun Witness2 () String (seq.++ "A" (seq.++ "K" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "A" "A") (re.union (re.range "K" "L")(re.union (re.range "R" "R") (re.range "Z" "Z"))))(re.union (re.++ (re.range "C" "C") (re.union (re.range "A" "A")(re.union (re.range "O" "O") (re.range "T" "T"))))(re.union (re.++ (re.range "D" "D") (re.union (re.range "C" "C") (re.range "E" "E")))(re.union (str.to_re (seq.++ "F" (seq.++ "L" "")))(re.union (str.to_re (seq.++ "G" (seq.++ "A" "")))(re.union (str.to_re (seq.++ "H" (seq.++ "I" "")))(re.union (re.++ (re.range "I" "I") (re.union (re.range "A" "A")(re.union (re.range "D" "D")(re.union (re.range "L" "L") (re.range "N" "N")))))(re.union (re.++ (re.range "K" "K") (re.union (re.range "S" "S") (re.range "Y" "Y")))(re.union (str.to_re (seq.++ "L" (seq.++ "A" "")))(re.union (re.++ (re.range "M" "M") (re.union (re.range "A" "A")(re.union (re.range "D" "E")(re.union (re.range "I" "I")(re.union (re.range "N" "O") (re.range "S" "T"))))))(re.union (re.++ (re.range "N" "N") (re.union (re.range "C" "E")(re.union (re.range "H" "H")(re.union (re.range "J" "J")(re.union (re.range "M" "M")(re.union (re.range "V" "V") (re.range "Y" "Y")))))))(re.union (re.++ (re.range "O" "O") (re.union (re.range "H" "H")(re.union (re.range "K" "K") (re.range "R" "R"))))(re.union (str.to_re (seq.++ "P" (seq.++ "A" "")))(re.union (str.to_re (seq.++ "R" (seq.++ "I" "")))(re.union (re.++ (re.range "S" "S") (re.range "C" "D"))(re.union (re.++ (re.range "T" "T") (re.union (re.range "N" "N") (re.range "X" "X")))(re.union (str.to_re (seq.++ "U" (seq.++ "T" "")))(re.union (re.++ (re.range "V" "V") (re.union (re.range "A" "A") (re.range "T" "T"))) (re.++ (re.range "W" "W") (re.union (re.range "A" "A")(re.union (re.range "I" "I")(re.union (re.range "V" "V") (re.range "Y" "Y"))))))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
