;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((([A-PR-UWYZ])([0-9][0-9A-HJKS-UW]?))|(([A-PR-UWYZ][A-HK-Y])([0-9][0-9ABEHMNPRV-Y]?))\s{0,2}(([0-9])([ABD-HJLNP-UW-Z])([ABD-HJLNP-UW-Z])))|(((GI)(R))\s{0,2}((0)(A)(A)))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0089KGIR\xD0AA"
(define-fun Witness1 () String (seq.++ "\x89" (seq.++ "K" (seq.++ "G" (seq.++ "I" (seq.++ "R" (seq.++ "\x0d" (seq.++ "0" (seq.++ "A" (seq.++ "A" ""))))))))))
;witness2: "#\xCGIR0AA"
(define-fun Witness2 () String (seq.++ "#" (seq.++ "\x0c" (seq.++ "G" (seq.++ "I" (seq.++ "R" (seq.++ "0" (seq.++ "A" (seq.++ "A" "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.union (re.++ (re.union (re.range "A" "P")(re.union (re.range "R" "U")(re.union (re.range "W" "W") (re.range "Y" "Z")))) (re.++ (re.range "0" "9") (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "H")(re.union (re.range "J" "K")(re.union (re.range "S" "U") (re.range "W" "W")))))))) (re.++ (re.++ (re.++ (re.union (re.range "A" "P")(re.union (re.range "R" "U")(re.union (re.range "W" "W") (re.range "Y" "Z")))) (re.union (re.range "A" "H") (re.range "K" "Y"))) (re.++ (re.range "0" "9") (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "M" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "R") (re.range "V" "Y")))))))))))(re.++ ((_ re.loop 0 2) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "B")(re.union (re.range "D" "H")(re.union (re.range "J" "J")(re.union (re.range "L" "L")(re.union (re.range "N" "N")(re.union (re.range "P" "U") (re.range "W" "Z"))))))) (re.union (re.range "A" "B")(re.union (re.range "D" "H")(re.union (re.range "J" "J")(re.union (re.range "L" "L")(re.union (re.range "N" "N")(re.union (re.range "P" "U") (re.range "W" "Z"))))))))))))) (re.++ (re.++ (re.++ (str.to_re (seq.++ "G" (seq.++ "I" ""))) (re.range "R" "R"))(re.++ ((_ re.loop 0 2) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.++ (re.range "0" "0")(re.++ (re.range "A" "A") (re.range "A" "A"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
