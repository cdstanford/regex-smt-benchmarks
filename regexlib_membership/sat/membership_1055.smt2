;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(((GIR)\s{0,1}((0AA))))|(([A-PR-UWYZ][0-9][0-9]?)|([A-PR-UWYZ][A-HK-Y][0-9][0-9]?)|([A-PR-UWYZ][0-9][A-HJKSTUW])|([A-PR-UWYZ][A-HK-Y][0-9][ABEHMNPRVWXY]))\s{0,1}([0-9][ABD-HJLNP-UW-Z]{2})$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0093\u00CEBY5P 7SU"
(define-fun Witness1 () String (seq.++ "\x93" (seq.++ "\xce" (seq.++ "B" (seq.++ "Y" (seq.++ "5" (seq.++ "P" (seq.++ " " (seq.++ "7" (seq.++ "S" (seq.++ "U" "")))))))))))
;witness2: "\x9j\x1FoH89TY"
(define-fun Witness2 () String (seq.++ "\x09" (seq.++ "j" (seq.++ "\x1f" (seq.++ "o" (seq.++ "H" (seq.++ "8" (seq.++ "9" (seq.++ "T" (seq.++ "Y" ""))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ (str.to_re (seq.++ "G" (seq.++ "I" (seq.++ "R" ""))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re (seq.++ "0" (seq.++ "A" (seq.++ "A" ""))))))) (re.++ (re.union (re.++ (re.union (re.range "A" "P")(re.union (re.range "R" "U")(re.union (re.range "W" "W") (re.range "Y" "Z"))))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))(re.union (re.++ (re.union (re.range "A" "P")(re.union (re.range "R" "U")(re.union (re.range "W" "W") (re.range "Y" "Z"))))(re.++ (re.union (re.range "A" "H") (re.range "K" "Y"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))(re.union (re.++ (re.union (re.range "A" "P")(re.union (re.range "R" "U")(re.union (re.range "W" "W") (re.range "Y" "Z"))))(re.++ (re.range "0" "9") (re.union (re.range "A" "H")(re.union (re.range "J" "K")(re.union (re.range "S" "U") (re.range "W" "W")))))) (re.++ (re.union (re.range "A" "P")(re.union (re.range "R" "U")(re.union (re.range "W" "W") (re.range "Y" "Z"))))(re.++ (re.union (re.range "A" "H") (re.range "K" "Y"))(re.++ (re.range "0" "9") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "M" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "R") (re.range "V" "Y")))))))))))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.++ (re.range "0" "9") ((_ re.loop 2 2) (re.union (re.range "A" "B")(re.union (re.range "D" "H")(re.union (re.range "J" "J")(re.union (re.range "L" "L")(re.union (re.range "N" "N")(re.union (re.range "P" "U") (re.range "W" "Z"))))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
