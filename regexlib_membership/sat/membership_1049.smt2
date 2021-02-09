;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((([A-PR-UWYZ](\d([A-HJKSTUW]|\d)?|[A-HK-Y]\d([ABEHMNPRVWXY]|\d)?))\s*(\d[ABD-HJLNP-UW-Z]{2})?)|GIR\s*0AA)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "GIR \u00850AA"
(define-fun Witness1 () String (seq.++ "G" (seq.++ "I" (seq.++ "R" (seq.++ " " (seq.++ "\x85" (seq.++ "0" (seq.++ "A" (seq.++ "A" "")))))))))
;witness2: "LL9 "
(define-fun Witness2 () String (seq.++ "L" (seq.++ "L" (seq.++ "9" (seq.++ " " "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.++ (re.union (re.range "A" "P")(re.union (re.range "R" "U")(re.union (re.range "W" "W") (re.range "Y" "Z")))) (re.union (re.++ (re.range "0" "9") (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "H")(re.union (re.range "J" "K")(re.union (re.range "S" "U") (re.range "W" "W"))))))) (re.++ (re.union (re.range "A" "H") (re.range "K" "Y"))(re.++ (re.range "0" "9") (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "M" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "R") (re.range "V" "Y")))))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.opt (re.++ (re.range "0" "9") ((_ re.loop 2 2) (re.union (re.range "A" "B")(re.union (re.range "D" "H")(re.union (re.range "J" "J")(re.union (re.range "L" "L")(re.union (re.range "N" "N")(re.union (re.range "P" "U") (re.range "W" "Z")))))))))))) (re.++ (str.to_re (seq.++ "G" (seq.++ "I" (seq.++ "R" ""))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re (seq.++ "0" (seq.++ "A" (seq.++ "A" ""))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
