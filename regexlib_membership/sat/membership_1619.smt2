;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((AL)|(AK)|(AS)|(AZ)|(AR)|(CA)|(CO)|(CT)|(DE)|(DC)|(FM)|(FL)|(GA)|(GU)|(HI)|(ID)|(IL)|(IN)|(IA)|(KS)|(KY)|(LA)|(ME)|(MH)|(MD)|(MA)|(MI)|(MN)|(MS)|(MO)|(MT)|(NE)|(NV)|(NH)|(NJ)|(NM)|(NY)|(NC)|(ND)|(MP)|(OH)|(OK)|(OR)|(PW)|(PA)|(PR)|(RI)|(SC)|(SD)|(TN)|(TX)|(UT)|(VT)|(VI)|(VA)|(WA)|(WV)|(WI)|(WY))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "GU"
(define-fun Witness1 () String (str.++ "G" (str.++ "U" "")))
;witness2: "UT"
(define-fun Witness2 () String (str.++ "U" (str.++ "T" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (str.++ "A" (str.++ "L" "")))(re.union (str.to_re (str.++ "A" (str.++ "K" "")))(re.union (str.to_re (str.++ "A" (str.++ "S" "")))(re.union (str.to_re (str.++ "A" (str.++ "Z" "")))(re.union (str.to_re (str.++ "A" (str.++ "R" "")))(re.union (str.to_re (str.++ "C" (str.++ "A" "")))(re.union (str.to_re (str.++ "C" (str.++ "O" "")))(re.union (str.to_re (str.++ "C" (str.++ "T" "")))(re.union (str.to_re (str.++ "D" (str.++ "E" "")))(re.union (str.to_re (str.++ "D" (str.++ "C" "")))(re.union (str.to_re (str.++ "F" (str.++ "M" "")))(re.union (str.to_re (str.++ "F" (str.++ "L" "")))(re.union (str.to_re (str.++ "G" (str.++ "A" "")))(re.union (str.to_re (str.++ "G" (str.++ "U" "")))(re.union (str.to_re (str.++ "H" (str.++ "I" "")))(re.union (str.to_re (str.++ "I" (str.++ "D" "")))(re.union (str.to_re (str.++ "I" (str.++ "L" "")))(re.union (str.to_re (str.++ "I" (str.++ "N" "")))(re.union (str.to_re (str.++ "I" (str.++ "A" "")))(re.union (str.to_re (str.++ "K" (str.++ "S" "")))(re.union (str.to_re (str.++ "K" (str.++ "Y" "")))(re.union (str.to_re (str.++ "L" (str.++ "A" "")))(re.union (str.to_re (str.++ "M" (str.++ "E" "")))(re.union (str.to_re (str.++ "M" (str.++ "H" "")))(re.union (str.to_re (str.++ "M" (str.++ "D" "")))(re.union (str.to_re (str.++ "M" (str.++ "A" "")))(re.union (str.to_re (str.++ "M" (str.++ "I" "")))(re.union (str.to_re (str.++ "M" (str.++ "N" "")))(re.union (str.to_re (str.++ "M" (str.++ "S" "")))(re.union (str.to_re (str.++ "M" (str.++ "O" "")))(re.union (str.to_re (str.++ "M" (str.++ "T" "")))(re.union (str.to_re (str.++ "N" (str.++ "E" "")))(re.union (str.to_re (str.++ "N" (str.++ "V" "")))(re.union (str.to_re (str.++ "N" (str.++ "H" "")))(re.union (str.to_re (str.++ "N" (str.++ "J" "")))(re.union (str.to_re (str.++ "N" (str.++ "M" "")))(re.union (str.to_re (str.++ "N" (str.++ "Y" "")))(re.union (str.to_re (str.++ "N" (str.++ "C" "")))(re.union (str.to_re (str.++ "N" (str.++ "D" "")))(re.union (str.to_re (str.++ "M" (str.++ "P" "")))(re.union (str.to_re (str.++ "O" (str.++ "H" "")))(re.union (str.to_re (str.++ "O" (str.++ "K" "")))(re.union (str.to_re (str.++ "O" (str.++ "R" "")))(re.union (str.to_re (str.++ "P" (str.++ "W" "")))(re.union (str.to_re (str.++ "P" (str.++ "A" "")))(re.union (str.to_re (str.++ "P" (str.++ "R" "")))(re.union (str.to_re (str.++ "R" (str.++ "I" "")))(re.union (str.to_re (str.++ "S" (str.++ "C" "")))(re.union (str.to_re (str.++ "S" (str.++ "D" "")))(re.union (str.to_re (str.++ "T" (str.++ "N" "")))(re.union (str.to_re (str.++ "T" (str.++ "X" "")))(re.union (str.to_re (str.++ "U" (str.++ "T" "")))(re.union (str.to_re (str.++ "V" (str.++ "T" "")))(re.union (str.to_re (str.++ "V" (str.++ "I" "")))(re.union (str.to_re (str.++ "V" (str.++ "A" "")))(re.union (str.to_re (str.++ "W" (str.++ "A" "")))(re.union (str.to_re (str.++ "W" (str.++ "V" "")))(re.union (str.to_re (str.++ "W" (str.++ "I" ""))) (str.to_re (str.++ "W" (str.++ "Y" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
