;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((AL)|(AK)|(AS)|(AZ)|(AR)|(CA)|(CO)|(CT)|(DE)|(DC)|(FM)|(FL)|(GA)|(GU)|(HI)|(ID)|(IL)|(IN)|(IA)|(KS)|(KY)|(LA)|(ME)|(MH)|(MD)|(MA)|(MI)|(MN)|(MS)|(MO)|(MT)|(NE)|(NV)|(NH)|(NJ)|(NM)|(NY)|(NC)|(ND)|(MP)|(OH)|(OK)|(OR)|(PW)|(PA)|(PR)|(RI)|(SC)|(SD)|(TN)|(TX)|(UT)|(VT)|(VI)|(VA)|(WA)|(WV)|(WI)|(WY))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "GU"
(define-fun Witness1 () String (seq.++ "G" (seq.++ "U" "")))
;witness2: "UT"
(define-fun Witness2 () String (seq.++ "U" (seq.++ "T" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (seq.++ "A" (seq.++ "L" "")))(re.union (str.to_re (seq.++ "A" (seq.++ "K" "")))(re.union (str.to_re (seq.++ "A" (seq.++ "S" "")))(re.union (str.to_re (seq.++ "A" (seq.++ "Z" "")))(re.union (str.to_re (seq.++ "A" (seq.++ "R" "")))(re.union (str.to_re (seq.++ "C" (seq.++ "A" "")))(re.union (str.to_re (seq.++ "C" (seq.++ "O" "")))(re.union (str.to_re (seq.++ "C" (seq.++ "T" "")))(re.union (str.to_re (seq.++ "D" (seq.++ "E" "")))(re.union (str.to_re (seq.++ "D" (seq.++ "C" "")))(re.union (str.to_re (seq.++ "F" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "F" (seq.++ "L" "")))(re.union (str.to_re (seq.++ "G" (seq.++ "A" "")))(re.union (str.to_re (seq.++ "G" (seq.++ "U" "")))(re.union (str.to_re (seq.++ "H" (seq.++ "I" "")))(re.union (str.to_re (seq.++ "I" (seq.++ "D" "")))(re.union (str.to_re (seq.++ "I" (seq.++ "L" "")))(re.union (str.to_re (seq.++ "I" (seq.++ "N" "")))(re.union (str.to_re (seq.++ "I" (seq.++ "A" "")))(re.union (str.to_re (seq.++ "K" (seq.++ "S" "")))(re.union (str.to_re (seq.++ "K" (seq.++ "Y" "")))(re.union (str.to_re (seq.++ "L" (seq.++ "A" "")))(re.union (str.to_re (seq.++ "M" (seq.++ "E" "")))(re.union (str.to_re (seq.++ "M" (seq.++ "H" "")))(re.union (str.to_re (seq.++ "M" (seq.++ "D" "")))(re.union (str.to_re (seq.++ "M" (seq.++ "A" "")))(re.union (str.to_re (seq.++ "M" (seq.++ "I" "")))(re.union (str.to_re (seq.++ "M" (seq.++ "N" "")))(re.union (str.to_re (seq.++ "M" (seq.++ "S" "")))(re.union (str.to_re (seq.++ "M" (seq.++ "O" "")))(re.union (str.to_re (seq.++ "M" (seq.++ "T" "")))(re.union (str.to_re (seq.++ "N" (seq.++ "E" "")))(re.union (str.to_re (seq.++ "N" (seq.++ "V" "")))(re.union (str.to_re (seq.++ "N" (seq.++ "H" "")))(re.union (str.to_re (seq.++ "N" (seq.++ "J" "")))(re.union (str.to_re (seq.++ "N" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "N" (seq.++ "Y" "")))(re.union (str.to_re (seq.++ "N" (seq.++ "C" "")))(re.union (str.to_re (seq.++ "N" (seq.++ "D" "")))(re.union (str.to_re (seq.++ "M" (seq.++ "P" "")))(re.union (str.to_re (seq.++ "O" (seq.++ "H" "")))(re.union (str.to_re (seq.++ "O" (seq.++ "K" "")))(re.union (str.to_re (seq.++ "O" (seq.++ "R" "")))(re.union (str.to_re (seq.++ "P" (seq.++ "W" "")))(re.union (str.to_re (seq.++ "P" (seq.++ "A" "")))(re.union (str.to_re (seq.++ "P" (seq.++ "R" "")))(re.union (str.to_re (seq.++ "R" (seq.++ "I" "")))(re.union (str.to_re (seq.++ "S" (seq.++ "C" "")))(re.union (str.to_re (seq.++ "S" (seq.++ "D" "")))(re.union (str.to_re (seq.++ "T" (seq.++ "N" "")))(re.union (str.to_re (seq.++ "T" (seq.++ "X" "")))(re.union (str.to_re (seq.++ "U" (seq.++ "T" "")))(re.union (str.to_re (seq.++ "V" (seq.++ "T" "")))(re.union (str.to_re (seq.++ "V" (seq.++ "I" "")))(re.union (str.to_re (seq.++ "V" (seq.++ "A" "")))(re.union (str.to_re (seq.++ "W" (seq.++ "A" "")))(re.union (str.to_re (seq.++ "W" (seq.++ "V" "")))(re.union (str.to_re (seq.++ "W" (seq.++ "I" ""))) (str.to_re (seq.++ "W" (seq.++ "Y" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
