;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((A(((H[MX])|(M(P|SN))|(X((D[ACH])|(M[DS]))?)))?)|(K7(A)?)|(D(H[DLM])?))(\d{3,4})[ABD-G][CHJK-NPQT-Y][Q-TV][1-4][B-E]$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "DHL8889DYR4D"
(define-fun Witness1 () String (str.++ "D" (str.++ "H" (str.++ "L" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "D" (str.++ "Y" (str.++ "R" (str.++ "4" (str.++ "D" "")))))))))))))
;witness2: "D8888BXR1E"
(define-fun Witness2 () String (str.++ "D" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "B" (str.++ "X" (str.++ "R" (str.++ "1" (str.++ "E" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "A" "A") (re.opt (re.union (re.++ (re.range "H" "H") (re.union (re.range "M" "M") (re.range "X" "X")))(re.union (re.++ (re.range "M" "M") (re.union (re.range "P" "P") (str.to_re (str.++ "S" (str.++ "N" ""))))) (re.++ (re.range "X" "X") (re.opt (re.union (re.++ (re.range "D" "D") (re.union (re.range "A" "A")(re.union (re.range "C" "C") (re.range "H" "H")))) (re.++ (re.range "M" "M") (re.union (re.range "D" "D") (re.range "S" "S"))))))))))(re.union (re.++ (str.to_re (str.++ "K" (str.++ "7" ""))) (re.opt (re.range "A" "A"))) (re.++ (re.range "D" "D") (re.opt (re.++ (re.range "H" "H") (re.union (re.range "D" "D") (re.range "L" "M")))))))(re.++ ((_ re.loop 3 4) (re.range "0" "9"))(re.++ (re.union (re.range "A" "B") (re.range "D" "G"))(re.++ (re.union (re.range "C" "C")(re.union (re.range "H" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "Q") (re.range "T" "Y")))))(re.++ (re.union (re.range "Q" "T") (re.range "V" "V"))(re.++ (re.range "1" "4")(re.++ (re.range "B" "E") (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
