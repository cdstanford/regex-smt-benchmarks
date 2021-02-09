;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([\#]{0,1}([a-fA-F0-9]{6}|[a-fA-F0-9]{3})|rgb\(([0-9]{1},|[1-9]{1}[0-9]{1},|[1]{1}[0-9]{2},|[2]{1}[0-4]{1}[0-9]{1},|25[0-5]{1},){2}([0-9]{1}|[1-9]{1}[0-9]{1}|[1]{1}[0-9]{2}|[2]{1}[0-4]{1}[0-9]{1}|25[0-5]{1}){1}\)|rgb\(([0-9]{1}%,|[1-9]{1}[0-9]{1}%,|100%,){2}([0-9]{1}%|[1-9]{1}[0-9]{1}%|100%){1}\))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "#a28088"
(define-fun Witness1 () String (seq.++ "#" (seq.++ "a" (seq.++ "2" (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ "8" ""))))))))
;witness2: "F9a"
(define-fun Witness2 () String (seq.++ "F" (seq.++ "9" (seq.++ "a" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "#" "#")) (re.union ((_ re.loop 6 6) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))(re.union (re.++ (str.to_re (seq.++ "r" (seq.++ "g" (seq.++ "b" (seq.++ "(" "")))))(re.++ ((_ re.loop 2 2) (re.union (re.++ (re.range "0" "9") (re.range "," ","))(re.union (re.++ (re.range "1" "9")(re.++ (re.range "0" "9") (re.range "," ",")))(re.union (re.++ (re.range "1" "1")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.range "," ",")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4")(re.++ (re.range "0" "9") (re.range "," ",")))) (re.++ (str.to_re (seq.++ "2" (seq.++ "5" "")))(re.++ (re.range "0" "5") (re.range "," ","))))))))(re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "1" "9") (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5")))))) (re.range ")" ")")))) (re.++ (str.to_re (seq.++ "r" (seq.++ "g" (seq.++ "b" (seq.++ "(" "")))))(re.++ ((_ re.loop 2 2) (re.union (re.++ (re.range "0" "9") (str.to_re (seq.++ "%" (seq.++ "," ""))))(re.union (re.++ (re.range "1" "9")(re.++ (re.range "0" "9") (str.to_re (seq.++ "%" (seq.++ "," ""))))) (str.to_re (seq.++ "1" (seq.++ "0" (seq.++ "0" (seq.++ "%" (seq.++ "," "")))))))))(re.++ (re.union (re.++ (re.range "0" "9") (re.range "%" "%"))(re.union (re.++ (re.range "1" "9")(re.++ (re.range "0" "9") (re.range "%" "%"))) (str.to_re (seq.++ "1" (seq.++ "0" (seq.++ "0" (seq.++ "%" ""))))))) (re.range ")" ")")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
