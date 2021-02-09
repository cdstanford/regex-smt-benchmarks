;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(GIR\\s{0,1}0AA|[A-PR-UWYZ]([0-9]{1,2}|([A-HK-Y][0-9]|[A-HK-Y][0-9]([0-9]|[ABEHMNPRV-Y]))|[0-9][A-HJKS-UW])\\s{0,1}[0-9][ABD-HJLNP-UW-Z]{2})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "O9\s5XZ"
(define-fun Witness1 () String (seq.++ "O" (seq.++ "9" (seq.++ "\x5c" (seq.++ "s" (seq.++ "5" (seq.++ "X" (seq.++ "Z" ""))))))))
;witness2: "AD2\s9LA"
(define-fun Witness2 () String (seq.++ "A" (seq.++ "D" (seq.++ "2" (seq.++ "\x5c" (seq.++ "s" (seq.++ "9" (seq.++ "L" (seq.++ "A" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (seq.++ "G" (seq.++ "I" (seq.++ "R" (seq.++ "\x5c" "")))))(re.++ (re.opt (re.range "s" "s")) (str.to_re (seq.++ "0" (seq.++ "A" (seq.++ "A" "")))))) (re.++ (re.union (re.range "A" "P")(re.union (re.range "R" "U")(re.union (re.range "W" "W") (re.range "Y" "Z"))))(re.++ (re.union ((_ re.loop 1 2) (re.range "0" "9"))(re.union (re.union (re.++ (re.union (re.range "A" "H") (re.range "K" "Y")) (re.range "0" "9")) (re.++ (re.union (re.range "A" "H") (re.range "K" "Y"))(re.++ (re.range "0" "9") (re.union (re.range "0" "9")(re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "M" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "R") (re.range "V" "Y"))))))))))) (re.++ (re.range "0" "9") (re.union (re.range "A" "H")(re.union (re.range "J" "K")(re.union (re.range "S" "U") (re.range "W" "W")))))))(re.++ (re.range "\x5c" "\x5c")(re.++ (re.opt (re.range "s" "s"))(re.++ (re.range "0" "9") ((_ re.loop 2 2) (re.union (re.range "A" "B")(re.union (re.range "D" "H")(re.union (re.range "J" "J")(re.union (re.range "L" "L")(re.union (re.range "N" "N")(re.union (re.range "P" "U") (re.range "W" "Z")))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
