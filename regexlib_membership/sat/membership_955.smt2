;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(H(P|T|U|Y|Z)|N(A|B|C|D|F|G|H|J|K|L|M|N|O|R|S|T|U|W|X|Y|Z)|OV|S(C|D|E|G|H|J|K|M|N|O|P|R|S|T|U|W|X|Y|Z)|T(A|F|G|L|M|Q|R|V)){1}\d{4}(NE|NW|SE|SW)?$|((H(P|T|U|Y|Z)|N(A|B|C|D|F|G|H|J|K|L|M|N|O|R|S|T|U|W|X|Y|Z)|OV|S(C|D|E|G|H|J|K|M|N|O|P|R|S|T|U|W|X|Y|Z)|T(A|F|G|L|M|Q|R|V)){1}(\d{4}|\d{6}|\d{8}|\d{10}))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "TL95039894"
(define-fun Witness1 () String (seq.++ "T" (seq.++ "L" (seq.++ "9" (seq.++ "5" (seq.++ "0" (seq.++ "3" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "4" "")))))))))))
;witness2: "SK4608"
(define-fun Witness2 () String (seq.++ "S" (seq.++ "K" (seq.++ "4" (seq.++ "6" (seq.++ "0" (seq.++ "8" "")))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "H" "H") (re.union (re.range "P" "P")(re.union (re.range "T" "U") (re.range "Y" "Z"))))(re.union (re.++ (re.range "N" "N") (re.union (re.range "A" "D")(re.union (re.range "F" "H")(re.union (re.range "J" "O")(re.union (re.range "R" "U") (re.range "W" "Z"))))))(re.union (str.to_re (seq.++ "O" (seq.++ "V" "")))(re.union (re.++ (re.range "S" "S") (re.union (re.range "C" "E")(re.union (re.range "G" "H")(re.union (re.range "J" "K")(re.union (re.range "M" "P")(re.union (re.range "R" "U") (re.range "W" "Z"))))))) (re.++ (re.range "T" "T") (re.union (re.range "A" "A")(re.union (re.range "F" "G")(re.union (re.range "L" "M")(re.union (re.range "Q" "R") (re.range "V" "V"))))))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (str.to_re (seq.++ "N" (seq.++ "E" "")))(re.union (str.to_re (seq.++ "N" (seq.++ "W" "")))(re.union (str.to_re (seq.++ "S" (seq.++ "E" ""))) (str.to_re (seq.++ "S" (seq.++ "W" ""))))))) (str.to_re ""))))) (re.++ (re.++ (re.union (re.++ (re.range "H" "H") (re.union (re.range "P" "P")(re.union (re.range "T" "U") (re.range "Y" "Z"))))(re.union (re.++ (re.range "N" "N") (re.union (re.range "A" "D")(re.union (re.range "F" "H")(re.union (re.range "J" "O")(re.union (re.range "R" "U") (re.range "W" "Z"))))))(re.union (str.to_re (seq.++ "O" (seq.++ "V" "")))(re.union (re.++ (re.range "S" "S") (re.union (re.range "C" "E")(re.union (re.range "G" "H")(re.union (re.range "J" "K")(re.union (re.range "M" "P")(re.union (re.range "R" "U") (re.range "W" "Z"))))))) (re.++ (re.range "T" "T") (re.union (re.range "A" "A")(re.union (re.range "F" "G")(re.union (re.range "L" "M")(re.union (re.range "Q" "R") (re.range "V" "V")))))))))) (re.union ((_ re.loop 4 4) (re.range "0" "9"))(re.union ((_ re.loop 6 6) (re.range "0" "9"))(re.union ((_ re.loop 8 8) (re.range "0" "9")) ((_ re.loop 10 10) (re.range "0" "9")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
