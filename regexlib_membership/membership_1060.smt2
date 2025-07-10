;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]{10}$|^\(0[1-9]{1}\)[0-9]{8}$|^[0-9]{8}$|^[0-9]{4}[ ][0-9]{3}[ ][0-9]{3}$|^\(0[1-9]{1}\)[ ][0-9]{4}[ ][0-9]{4}$|^[0-9]{4}[ ][0-9]{4}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0768 668 840"
(define-fun Witness1 () String (str.++ "0" (str.++ "7" (str.++ "6" (str.++ "8" (str.++ " " (str.++ "6" (str.++ "6" (str.++ "8" (str.++ " " (str.++ "8" (str.++ "4" (str.++ "0" "")))))))))))))
;witness2: "(01)69707389"
(define-fun Witness2 () String (str.++ "(" (str.++ "0" (str.++ "1" (str.++ ")" (str.++ "6" (str.++ "9" (str.++ "7" (str.++ "0" (str.++ "7" (str.++ "3" (str.++ "8" (str.++ "9" "")))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "(" (str.++ "0" "")))(re.++ (re.range "1" "9")(re.++ (re.range ")" ")")(re.++ ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re "")))))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "(" (str.++ "0" "")))(re.++ (re.range "1" "9")(re.++ (str.to_re (str.++ ")" (str.++ " " "")))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))) (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
