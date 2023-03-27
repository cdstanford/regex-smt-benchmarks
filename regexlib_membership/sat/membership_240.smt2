;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([\#]{0,1}([a-fA-F0-9]{6}|[a-fA-F0-9]{3})|rgb\(([0-9]{1},|[1-9]{1}[0-9]{1},|[1]{1}[0-9]{2},|[2]{1}[0-4]{1}[0-9]{1},|25[0-5]{1},){2}([0-9]{1}|[1-9]{1}[0-9]{1}|[1]{1}[0-9]{2}|[2]{1}[0-4]{1}[0-9]{1}|25[0-5]{1}){1}\)|rgb\(([0-9]{1}%,|[1-9]{1}[0-9]{1}%,|100%,){2}([0-9]{1}%|[1-9]{1}[0-9]{1}%|100%){1}\))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "#a28088"
(define-fun Witness1 () String (str.++ "#" (str.++ "a" (str.++ "2" (str.++ "8" (str.++ "0" (str.++ "8" (str.++ "8" ""))))))))
;witness2: "F9a"
(define-fun Witness2 () String (str.++ "F" (str.++ "9" (str.++ "a" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "#" "#")) (re.union ((_ re.loop 6 6) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))(re.union (re.++ (str.to_re (str.++ "r" (str.++ "g" (str.++ "b" (str.++ "(" "")))))(re.++ ((_ re.loop 2 2) (re.union (re.++ (re.range "0" "9") (re.range "," ","))(re.union (re.++ (re.range "1" "9")(re.++ (re.range "0" "9") (re.range "," ",")))(re.union (re.++ (re.range "1" "1")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.range "," ",")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4")(re.++ (re.range "0" "9") (re.range "," ",")))) (re.++ (str.to_re (str.++ "2" (str.++ "5" "")))(re.++ (re.range "0" "5") (re.range "," ","))))))))(re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "1" "9") (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5")))))) (re.range ")" ")")))) (re.++ (str.to_re (str.++ "r" (str.++ "g" (str.++ "b" (str.++ "(" "")))))(re.++ ((_ re.loop 2 2) (re.union (re.++ (re.range "0" "9") (str.to_re (str.++ "%" (str.++ "," ""))))(re.union (re.++ (re.range "1" "9")(re.++ (re.range "0" "9") (str.to_re (str.++ "%" (str.++ "," ""))))) (str.to_re (str.++ "1" (str.++ "0" (str.++ "0" (str.++ "%" (str.++ "," "")))))))))(re.++ (re.union (re.++ (re.range "0" "9") (re.range "%" "%"))(re.union (re.++ (re.range "1" "9")(re.++ (re.range "0" "9") (re.range "%" "%"))) (str.to_re (str.++ "1" (str.++ "0" (str.++ "0" (str.++ "%" ""))))))) (re.range ")" ")")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
