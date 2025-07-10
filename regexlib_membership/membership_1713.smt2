;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-PR-UWYZ0-9][A-HK-Y0-9][AEHMNPRTVXY0-9]?[ABEHMNPRVWXY0-9]? {1,2}[0-9][ABD-HJLN-UW-Z]{2}|GIR 0AA)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9413 8AB"
(define-fun Witness1 () String (str.++ "9" (str.++ "4" (str.++ "1" (str.++ "3" (str.++ " " (str.++ "8" (str.++ "A" (str.++ "B" "")))))))))
;witness2: "GIR 0AA"
(define-fun Witness2 () String (str.++ "G" (str.++ "I" (str.++ "R" (str.++ " " (str.++ "0" (str.++ "A" (str.++ "A" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "P")(re.union (re.range "R" "U")(re.union (re.range "W" "W") (re.range "Y" "Z")))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "H") (re.range "K" "Y")))(re.++ (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "A")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "M" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "R")(re.union (re.range "T" "T")(re.union (re.range "V" "V") (re.range "X" "Y")))))))))))(re.++ (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "M" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "R") (re.range "V" "Y")))))))))(re.++ ((_ re.loop 1 2) (re.range " " " "))(re.++ (re.range "0" "9") ((_ re.loop 2 2) (re.union (re.range "A" "B")(re.union (re.range "D" "H")(re.union (re.range "J" "J")(re.union (re.range "L" "L")(re.union (re.range "N" "U") (re.range "W" "Z"))))))))))))) (str.to_re (str.++ "G" (str.++ "I" (str.++ "R" (str.++ " " (str.++ "0" (str.++ "A" (str.++ "A" ""))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
