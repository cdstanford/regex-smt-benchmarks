;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<From>(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER|[ ]|,|/|[0-9])+)(-|–|:|TO)?(?<To>(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER|[ ]|,|/|[0-9]|PRESENT)+)+(:)*
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "NOVEMBERJUNEMAYDECEMBERTOAUGUST:"
(define-fun Witness1 () String (str.++ "N" (str.++ "O" (str.++ "V" (str.++ "E" (str.++ "M" (str.++ "B" (str.++ "E" (str.++ "R" (str.++ "J" (str.++ "U" (str.++ "N" (str.++ "E" (str.++ "M" (str.++ "A" (str.++ "Y" (str.++ "D" (str.++ "E" (str.++ "C" (str.++ "E" (str.++ "M" (str.++ "B" (str.++ "E" (str.++ "R" (str.++ "T" (str.++ "O" (str.++ "A" (str.++ "U" (str.++ "G" (str.++ "U" (str.++ "S" (str.++ "T" (str.++ ":" "")))))))))))))))))))))))))))))))))
;witness2: "//OCTOBERMAYMARCHJULYFEBRUARYAUGUST OCTOBERAUGUSTFEBRUARYFEBRUARY-DECEMBER4SEPTEMBERJUNEJUNEFEBRUARYSEPTEMBER0MARCH MAYJUNEDECEMBERSEPTEMBERSEPTEMBERAUGUSTAPRILMARCHJULYAPRILMARCH::;\u008E"
(define-fun Witness2 () String (str.++ "/" (str.++ "/" (str.++ "O" (str.++ "C" (str.++ "T" (str.++ "O" (str.++ "B" (str.++ "E" (str.++ "R" (str.++ "M" (str.++ "A" (str.++ "Y" (str.++ "M" (str.++ "A" (str.++ "R" (str.++ "C" (str.++ "H" (str.++ "J" (str.++ "U" (str.++ "L" (str.++ "Y" (str.++ "F" (str.++ "E" (str.++ "B" (str.++ "R" (str.++ "U" (str.++ "A" (str.++ "R" (str.++ "Y" (str.++ "A" (str.++ "U" (str.++ "G" (str.++ "U" (str.++ "S" (str.++ "T" (str.++ " " (str.++ "O" (str.++ "C" (str.++ "T" (str.++ "O" (str.++ "B" (str.++ "E" (str.++ "R" (str.++ "A" (str.++ "U" (str.++ "G" (str.++ "U" (str.++ "S" (str.++ "T" (str.++ "F" (str.++ "E" (str.++ "B" (str.++ "R" (str.++ "U" (str.++ "A" (str.++ "R" (str.++ "Y" (str.++ "F" (str.++ "E" (str.++ "B" (str.++ "R" (str.++ "U" (str.++ "A" (str.++ "R" (str.++ "Y" (str.++ "-" (str.++ "D" (str.++ "E" (str.++ "C" (str.++ "E" (str.++ "M" (str.++ "B" (str.++ "E" (str.++ "R" (str.++ "4" (str.++ "S" (str.++ "E" (str.++ "P" (str.++ "T" (str.++ "E" (str.++ "M" (str.++ "B" (str.++ "E" (str.++ "R" (str.++ "J" (str.++ "U" (str.++ "N" (str.++ "E" (str.++ "J" (str.++ "U" (str.++ "N" (str.++ "E" (str.++ "F" (str.++ "E" (str.++ "B" (str.++ "R" (str.++ "U" (str.++ "A" (str.++ "R" (str.++ "Y" (str.++ "S" (str.++ "E" (str.++ "P" (str.++ "T" (str.++ "E" (str.++ "M" (str.++ "B" (str.++ "E" (str.++ "R" (str.++ "0" (str.++ "M" (str.++ "A" (str.++ "R" (str.++ "C" (str.++ "H" (str.++ " " (str.++ "M" (str.++ "A" (str.++ "Y" (str.++ "J" (str.++ "U" (str.++ "N" (str.++ "E" (str.++ "D" (str.++ "E" (str.++ "C" (str.++ "E" (str.++ "M" (str.++ "B" (str.++ "E" (str.++ "R" (str.++ "S" (str.++ "E" (str.++ "P" (str.++ "T" (str.++ "E" (str.++ "M" (str.++ "B" (str.++ "E" (str.++ "R" (str.++ "S" (str.++ "E" (str.++ "P" (str.++ "T" (str.++ "E" (str.++ "M" (str.++ "B" (str.++ "E" (str.++ "R" (str.++ "A" (str.++ "U" (str.++ "G" (str.++ "U" (str.++ "S" (str.++ "T" (str.++ "A" (str.++ "P" (str.++ "R" (str.++ "I" (str.++ "L" (str.++ "M" (str.++ "A" (str.++ "R" (str.++ "C" (str.++ "H" (str.++ "J" (str.++ "U" (str.++ "L" (str.++ "Y" (str.++ "A" (str.++ "P" (str.++ "R" (str.++ "I" (str.++ "L" (str.++ "M" (str.++ "A" (str.++ "R" (str.++ "C" (str.++ "H" (str.++ ":" (str.++ ":" (str.++ ";" (str.++ "\u{8e}" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (str.to_re (str.++ "J" (str.++ "A" (str.++ "N" (str.++ "U" (str.++ "A" (str.++ "R" (str.++ "Y" ""))))))))(re.union (str.to_re (str.++ "F" (str.++ "E" (str.++ "B" (str.++ "R" (str.++ "U" (str.++ "A" (str.++ "R" (str.++ "Y" "")))))))))(re.union (str.to_re (str.++ "M" (str.++ "A" (str.++ "R" (str.++ "C" (str.++ "H" ""))))))(re.union (str.to_re (str.++ "A" (str.++ "P" (str.++ "R" (str.++ "I" (str.++ "L" ""))))))(re.union (str.to_re (str.++ "M" (str.++ "A" (str.++ "Y" ""))))(re.union (str.to_re (str.++ "J" (str.++ "U" (str.++ "N" (str.++ "E" "")))))(re.union (str.to_re (str.++ "J" (str.++ "U" (str.++ "L" (str.++ "Y" "")))))(re.union (str.to_re (str.++ "A" (str.++ "U" (str.++ "G" (str.++ "U" (str.++ "S" (str.++ "T" "")))))))(re.union (str.to_re (str.++ "S" (str.++ "E" (str.++ "P" (str.++ "T" (str.++ "E" (str.++ "M" (str.++ "B" (str.++ "E" (str.++ "R" ""))))))))))(re.union (str.to_re (str.++ "O" (str.++ "C" (str.++ "T" (str.++ "O" (str.++ "B" (str.++ "E" (str.++ "R" ""))))))))(re.union (str.to_re (str.++ "N" (str.++ "O" (str.++ "V" (str.++ "E" (str.++ "M" (str.++ "B" (str.++ "E" (str.++ "R" "")))))))))(re.union (str.to_re (str.++ "D" (str.++ "E" (str.++ "C" (str.++ "E" (str.++ "M" (str.++ "B" (str.++ "E" (str.++ "R" ""))))))))) (re.union (re.range " " " ")(re.union (re.range "," ",") (re.range "/" "9"))))))))))))))))(re.++ (re.opt (re.union (re.union (re.range "-" "-")(re.union (re.range ":" ":") (re.range "\u{ff}" "\u{ff}"))) (str.to_re (str.++ "T" (str.++ "O" "")))))(re.++ (re.+ (re.+ (re.union (str.to_re (str.++ "J" (str.++ "A" (str.++ "N" (str.++ "U" (str.++ "A" (str.++ "R" (str.++ "Y" ""))))))))(re.union (str.to_re (str.++ "F" (str.++ "E" (str.++ "B" (str.++ "R" (str.++ "U" (str.++ "A" (str.++ "R" (str.++ "Y" "")))))))))(re.union (str.to_re (str.++ "M" (str.++ "A" (str.++ "R" (str.++ "C" (str.++ "H" ""))))))(re.union (str.to_re (str.++ "A" (str.++ "P" (str.++ "R" (str.++ "I" (str.++ "L" ""))))))(re.union (str.to_re (str.++ "M" (str.++ "A" (str.++ "Y" ""))))(re.union (str.to_re (str.++ "J" (str.++ "U" (str.++ "N" (str.++ "E" "")))))(re.union (str.to_re (str.++ "J" (str.++ "U" (str.++ "L" (str.++ "Y" "")))))(re.union (str.to_re (str.++ "A" (str.++ "U" (str.++ "G" (str.++ "U" (str.++ "S" (str.++ "T" "")))))))(re.union (str.to_re (str.++ "S" (str.++ "E" (str.++ "P" (str.++ "T" (str.++ "E" (str.++ "M" (str.++ "B" (str.++ "E" (str.++ "R" ""))))))))))(re.union (str.to_re (str.++ "O" (str.++ "C" (str.++ "T" (str.++ "O" (str.++ "B" (str.++ "E" (str.++ "R" ""))))))))(re.union (str.to_re (str.++ "N" (str.++ "O" (str.++ "V" (str.++ "E" (str.++ "M" (str.++ "B" (str.++ "E" (str.++ "R" "")))))))))(re.union (str.to_re (str.++ "D" (str.++ "E" (str.++ "C" (str.++ "E" (str.++ "M" (str.++ "B" (str.++ "E" (str.++ "R" "")))))))))(re.union (re.union (re.range " " " ")(re.union (re.range "," ",") (re.range "/" "9"))) (str.to_re (str.++ "P" (str.++ "R" (str.++ "E" (str.++ "S" (str.++ "E" (str.++ "N" (str.++ "T" ""))))))))))))))))))))))) (re.* (re.range ":" ":"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
