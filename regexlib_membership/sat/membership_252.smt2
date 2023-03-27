;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(B(A|B|C|J|L|N|R|S|Y)|CA|D(K|S|T)|G(A|L)|H(C|E)|IL|K(A|I|E|K|M|N|S)|L(E|C|M|V)|M(A|I|L|T|Y)|N(I|O|M|R|Z)|P(B|D|E|O|K|N|P|T|U|V)|R(A|K|S|V)|S(A|B|C|E|I|K|L|O|N|P|V)|T(A|C|N|O|R|S|T|V)|V(K|T)|Z(A|C|H|I|M|V))([ ]{0,1})([0-9]{3})([A-Z]{2})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "IL999YQ"
(define-fun Witness1 () String (str.++ "I" (str.++ "L" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "Y" (str.++ "Q" ""))))))))
;witness2: "GL988SM"
(define-fun Witness2 () String (str.++ "G" (str.++ "L" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "S" (str.++ "M" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "B" "B") (re.union (re.range "A" "C")(re.union (re.range "J" "J")(re.union (re.range "L" "L")(re.union (re.range "N" "N")(re.union (re.range "R" "S") (re.range "Y" "Y")))))))(re.union (str.to_re (str.++ "C" (str.++ "A" "")))(re.union (re.++ (re.range "D" "D") (re.union (re.range "K" "K") (re.range "S" "T")))(re.union (re.++ (re.range "G" "G") (re.union (re.range "A" "A") (re.range "L" "L")))(re.union (re.++ (re.range "H" "H") (re.union (re.range "C" "C") (re.range "E" "E")))(re.union (str.to_re (str.++ "I" (str.++ "L" "")))(re.union (re.++ (re.range "K" "K") (re.union (re.range "A" "A")(re.union (re.range "E" "E")(re.union (re.range "I" "I")(re.union (re.range "K" "K")(re.union (re.range "M" "N") (re.range "S" "S")))))))(re.union (re.++ (re.range "L" "L") (re.union (re.range "C" "C")(re.union (re.range "E" "E")(re.union (re.range "M" "M") (re.range "V" "V")))))(re.union (re.++ (re.range "M" "M") (re.union (re.range "A" "A")(re.union (re.range "I" "I")(re.union (re.range "L" "L")(re.union (re.range "T" "T") (re.range "Y" "Y"))))))(re.union (re.++ (re.range "N" "N") (re.union (re.range "I" "I")(re.union (re.range "M" "M")(re.union (re.range "O" "O")(re.union (re.range "R" "R") (re.range "Z" "Z"))))))(re.union (re.++ (re.range "P" "P") (re.union (re.range "B" "B")(re.union (re.range "D" "E")(re.union (re.range "K" "K")(re.union (re.range "N" "P") (re.range "T" "V"))))))(re.union (re.++ (re.range "R" "R") (re.union (re.range "A" "A")(re.union (re.range "K" "K")(re.union (re.range "S" "S") (re.range "V" "V")))))(re.union (re.++ (re.range "S" "S") (re.union (re.range "A" "C")(re.union (re.range "E" "E")(re.union (re.range "I" "I")(re.union (re.range "K" "L")(re.union (re.range "N" "P") (re.range "V" "V")))))))(re.union (re.++ (re.range "T" "T") (re.union (re.range "A" "A")(re.union (re.range "C" "C")(re.union (re.range "N" "O")(re.union (re.range "R" "T") (re.range "V" "V"))))))(re.union (re.++ (re.range "V" "V") (re.union (re.range "K" "K") (re.range "T" "T"))) (re.++ (re.range "Z" "Z") (re.union (re.range "A" "A")(re.union (re.range "C" "C")(re.union (re.range "H" "I")(re.union (re.range "M" "M") (re.range "V" "V")))))))))))))))))))))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ ((_ re.loop 2 2) (re.range "A" "Z")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
