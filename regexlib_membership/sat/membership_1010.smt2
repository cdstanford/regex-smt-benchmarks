;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Fa-f0-9]{32}$|({|\()?[A-Fa-f0-9]{8}-([A-Fa-f0-9]{4}-){3}[A-Fa-f0-9]{12}(}|\))?$|^({)?[0xA-Fa-f0-9]{3,10}(, {0,1}[0xA-Fa-f0-9]{3,6}){2}, {0,1}({)([0xA-Fa-f0-9]{3,4}, {0,1}){7}[0xA-Fa-f0-9]{3,4}(}})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "{xxe8a9, cE8e, ACE,{xExB, 9xf, 69D,0cA,789,A76, F40,59f}}"
(define-fun Witness1 () String (seq.++ "{" (seq.++ "x" (seq.++ "x" (seq.++ "e" (seq.++ "8" (seq.++ "a" (seq.++ "9" (seq.++ "," (seq.++ " " (seq.++ "c" (seq.++ "E" (seq.++ "8" (seq.++ "e" (seq.++ "," (seq.++ " " (seq.++ "A" (seq.++ "C" (seq.++ "E" (seq.++ "," (seq.++ "{" (seq.++ "x" (seq.++ "E" (seq.++ "x" (seq.++ "B" (seq.++ "," (seq.++ " " (seq.++ "9" (seq.++ "x" (seq.++ "f" (seq.++ "," (seq.++ " " (seq.++ "6" (seq.++ "9" (seq.++ "D" (seq.++ "," (seq.++ "0" (seq.++ "c" (seq.++ "A" (seq.++ "," (seq.++ "7" (seq.++ "8" (seq.++ "9" (seq.++ "," (seq.++ "A" (seq.++ "7" (seq.++ "6" (seq.++ "," (seq.++ " " (seq.++ "F" (seq.++ "4" (seq.++ "0" (seq.++ "," (seq.++ "5" (seq.++ "9" (seq.++ "f" (seq.++ "}" (seq.++ "}" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "9a48D303b088fAD96AfF2Fff0F9B2FbA"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "a" (seq.++ "4" (seq.++ "8" (seq.++ "D" (seq.++ "3" (seq.++ "0" (seq.++ "3" (seq.++ "b" (seq.++ "0" (seq.++ "8" (seq.++ "8" (seq.++ "f" (seq.++ "A" (seq.++ "D" (seq.++ "9" (seq.++ "6" (seq.++ "A" (seq.++ "f" (seq.++ "F" (seq.++ "2" (seq.++ "F" (seq.++ "f" (seq.++ "f" (seq.++ "0" (seq.++ "F" (seq.++ "9" (seq.++ "B" (seq.++ "2" (seq.++ "F" (seq.++ "b" (seq.++ "A" "")))))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 32 32) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (str.to_re "")))(re.union (re.++ (re.opt (re.union (re.range "(" "(") (re.range "{" "{")))(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range "-" "-")))(re.++ ((_ re.loop 12 12) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.union (re.range ")" ")") (re.range "}" "}"))) (str.to_re ""))))))) (re.++ (str.to_re "")(re.++ (re.opt (re.range "{" "{"))(re.++ ((_ re.loop 3 10) (re.union (re.range "0" "9")(re.union (re.range "A" "F")(re.union (re.range "a" "f") (re.range "x" "x")))))(re.++ ((_ re.loop 2 2) (re.++ (re.range "," ",")(re.++ (re.opt (re.range " " " ")) ((_ re.loop 3 6) (re.union (re.range "0" "9")(re.union (re.range "A" "F")(re.union (re.range "a" "f") (re.range "x" "x"))))))))(re.++ (re.range "," ",")(re.++ (re.opt (re.range " " " "))(re.++ (re.range "{" "{")(re.++ ((_ re.loop 7 7) (re.++ ((_ re.loop 3 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F")(re.union (re.range "a" "f") (re.range "x" "x")))))(re.++ (re.range "," ",") (re.opt (re.range " " " ")))))(re.++ ((_ re.loop 3 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F")(re.union (re.range "a" "f") (re.range "x" "x")))))(re.++ (str.to_re (seq.++ "}" (seq.++ "}" ""))) (str.to_re "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
