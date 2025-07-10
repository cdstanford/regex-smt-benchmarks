;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(((GIR)\s{0,1}((0AA))))|(([A-PR-UWYZ][0-9][0-9]?)|([A-PR-UWYZ][A-HK-Y][0-9][0-9]?)|([A-PR-UWYZ][0-9][A-HJKSTUW])|([A-PR-UWYZ][A-HK-Y][0-9][ABEHMNPRVWXY]))\s{0,1}([0-9][ABD-HJLNP-UW-Z]{2})$)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0093\u00CEBY5P 7SU"
(define-fun Witness1 () String (str.++ "\u{93}" (str.++ "\u{ce}" (str.++ "B" (str.++ "Y" (str.++ "5" (str.++ "P" (str.++ " " (str.++ "7" (str.++ "S" (str.++ "U" "")))))))))))
;witness2: "\x9j\x1FoH89TY"
(define-fun Witness2 () String (str.++ "\u{09}" (str.++ "j" (str.++ "\u{1f}" (str.++ "o" (str.++ "H" (str.++ "8" (str.++ "9" (str.++ "T" (str.++ "Y" ""))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ (str.to_re (str.++ "G" (str.++ "I" (str.++ "R" ""))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re (str.++ "0" (str.++ "A" (str.++ "A" ""))))))) (re.++ (re.union (re.++ (re.union (re.range "A" "P")(re.union (re.range "R" "U")(re.union (re.range "W" "W") (re.range "Y" "Z"))))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))(re.union (re.++ (re.union (re.range "A" "P")(re.union (re.range "R" "U")(re.union (re.range "W" "W") (re.range "Y" "Z"))))(re.++ (re.union (re.range "A" "H") (re.range "K" "Y"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))(re.union (re.++ (re.union (re.range "A" "P")(re.union (re.range "R" "U")(re.union (re.range "W" "W") (re.range "Y" "Z"))))(re.++ (re.range "0" "9") (re.union (re.range "A" "H")(re.union (re.range "J" "K")(re.union (re.range "S" "U") (re.range "W" "W")))))) (re.++ (re.union (re.range "A" "P")(re.union (re.range "R" "U")(re.union (re.range "W" "W") (re.range "Y" "Z"))))(re.++ (re.union (re.range "A" "H") (re.range "K" "Y"))(re.++ (re.range "0" "9") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "M" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "R") (re.range "V" "Y")))))))))))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.++ (re.range "0" "9") ((_ re.loop 2 2) (re.union (re.range "A" "B")(re.union (re.range "D" "H")(re.union (re.range "J" "J")(re.union (re.range "L" "L")(re.union (re.range "N" "N")(re.union (re.range "P" "U") (re.range "W" "Z"))))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
