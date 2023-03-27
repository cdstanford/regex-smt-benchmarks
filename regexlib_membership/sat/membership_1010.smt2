;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Fa-f0-9]{32}$|({|\()?[A-Fa-f0-9]{8}-([A-Fa-f0-9]{4}-){3}[A-Fa-f0-9]{12}(}|\))?$|^({)?[0xA-Fa-f0-9]{3,10}(, {0,1}[0xA-Fa-f0-9]{3,6}){2}, {0,1}({)([0xA-Fa-f0-9]{3,4}, {0,1}){7}[0xA-Fa-f0-9]{3,4}(}})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "{xxe8a9, cE8e, ACE,{xExB, 9xf, 69D,0cA,789,A76, F40,59f}}"
(define-fun Witness1 () String (str.++ "{" (str.++ "x" (str.++ "x" (str.++ "e" (str.++ "8" (str.++ "a" (str.++ "9" (str.++ "," (str.++ " " (str.++ "c" (str.++ "E" (str.++ "8" (str.++ "e" (str.++ "," (str.++ " " (str.++ "A" (str.++ "C" (str.++ "E" (str.++ "," (str.++ "{" (str.++ "x" (str.++ "E" (str.++ "x" (str.++ "B" (str.++ "," (str.++ " " (str.++ "9" (str.++ "x" (str.++ "f" (str.++ "," (str.++ " " (str.++ "6" (str.++ "9" (str.++ "D" (str.++ "," (str.++ "0" (str.++ "c" (str.++ "A" (str.++ "," (str.++ "7" (str.++ "8" (str.++ "9" (str.++ "," (str.++ "A" (str.++ "7" (str.++ "6" (str.++ "," (str.++ " " (str.++ "F" (str.++ "4" (str.++ "0" (str.++ "," (str.++ "5" (str.++ "9" (str.++ "f" (str.++ "}" (str.++ "}" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "9a48D303b088fAD96AfF2Fff0F9B2FbA"
(define-fun Witness2 () String (str.++ "9" (str.++ "a" (str.++ "4" (str.++ "8" (str.++ "D" (str.++ "3" (str.++ "0" (str.++ "3" (str.++ "b" (str.++ "0" (str.++ "8" (str.++ "8" (str.++ "f" (str.++ "A" (str.++ "D" (str.++ "9" (str.++ "6" (str.++ "A" (str.++ "f" (str.++ "F" (str.++ "2" (str.++ "F" (str.++ "f" (str.++ "f" (str.++ "0" (str.++ "F" (str.++ "9" (str.++ "B" (str.++ "2" (str.++ "F" (str.++ "b" (str.++ "A" "")))))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 32 32) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (str.to_re "")))(re.union (re.++ (re.opt (re.union (re.range "(" "(") (re.range "{" "{")))(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range "-" "-")))(re.++ ((_ re.loop 12 12) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.union (re.range ")" ")") (re.range "}" "}"))) (str.to_re ""))))))) (re.++ (str.to_re "")(re.++ (re.opt (re.range "{" "{"))(re.++ ((_ re.loop 3 10) (re.union (re.range "0" "9")(re.union (re.range "A" "F")(re.union (re.range "a" "f") (re.range "x" "x")))))(re.++ ((_ re.loop 2 2) (re.++ (re.range "," ",")(re.++ (re.opt (re.range " " " ")) ((_ re.loop 3 6) (re.union (re.range "0" "9")(re.union (re.range "A" "F")(re.union (re.range "a" "f") (re.range "x" "x"))))))))(re.++ (re.range "," ",")(re.++ (re.opt (re.range " " " "))(re.++ (re.range "{" "{")(re.++ ((_ re.loop 7 7) (re.++ ((_ re.loop 3 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F")(re.union (re.range "a" "f") (re.range "x" "x")))))(re.++ (re.range "," ",") (re.opt (re.range " " " ")))))(re.++ ((_ re.loop 3 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F")(re.union (re.range "a" "f") (re.range "x" "x")))))(re.++ (str.to_re (str.++ "}" (str.++ "}" ""))) (str.to_re "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
