;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(GIR ?0AA|(?:[A-PR-UWYZ](?:\d|\d{2}|[A-HK-Y]\d|[A-HK-Y]\d\d|\d[A-HJKSTUW]|[A-HK-Y]\d[ABEHMNPRV-Y])) ?\d[ABD-HJLNP-UW-Z]{2})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Z6 1SB"
(define-fun Witness1 () String (seq.++ "Z" (seq.++ "6" (seq.++ " " (seq.++ "1" (seq.++ "S" (seq.++ "B" "")))))))
;witness2: "T2S0ZX"
(define-fun Witness2 () String (seq.++ "T" (seq.++ "2" (seq.++ "S" (seq.++ "0" (seq.++ "Z" (seq.++ "X" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (seq.++ "G" (seq.++ "I" (seq.++ "R" ""))))(re.++ (re.opt (re.range " " " ")) (str.to_re (seq.++ "0" (seq.++ "A" (seq.++ "A" "")))))) (re.++ (re.union (re.range "A" "P")(re.union (re.range "R" "U")(re.union (re.range "W" "W") (re.range "Y" "Z"))))(re.++ (re.union (re.range "0" "9")(re.union ((_ re.loop 2 2) (re.range "0" "9"))(re.union (re.++ (re.union (re.range "A" "H") (re.range "K" "Y")) (re.range "0" "9"))(re.union (re.++ (re.union (re.range "A" "H") (re.range "K" "Y"))(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "0" "9") (re.union (re.range "A" "H")(re.union (re.range "J" "K")(re.union (re.range "S" "U") (re.range "W" "W"))))) (re.++ (re.union (re.range "A" "H") (re.range "K" "Y"))(re.++ (re.range "0" "9") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "M" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "R") (re.range "V" "Y"))))))))))))))(re.++ (re.opt (re.range " " " "))(re.++ (re.range "0" "9") ((_ re.loop 2 2) (re.union (re.range "A" "B")(re.union (re.range "D" "H")(re.union (re.range "J" "J")(re.union (re.range "L" "L")(re.union (re.range "N" "N")(re.union (re.range "P" "U") (re.range "W" "Z"))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
