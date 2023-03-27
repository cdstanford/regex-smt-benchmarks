;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(BE)[0-1]{1}[0-9]{9}$|^((BE)|(BE ))[0-1]{1}(\d{3})([.]{1})(\d{3})([.]{1})(\d{3})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "BE1084568897"
(define-fun Witness1 () String (str.++ "B" (str.++ "E" (str.++ "1" (str.++ "0" (str.++ "8" (str.++ "4" (str.++ "5" (str.++ "6" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "7" "")))))))))))))
;witness2: "BE1986988224"
(define-fun Witness2 () String (str.++ "B" (str.++ "E" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "2" (str.++ "2" (str.++ "4" "")))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "B" (str.++ "E" "")))(re.++ (re.range "0" "1")(re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re ""))))) (re.++ (str.to_re "")(re.++ (re.union (str.to_re (str.++ "B" (str.++ "E" ""))) (str.to_re (str.++ "B" (str.++ "E" (str.++ " " "")))))(re.++ (re.range "0" "1")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "." ".") ((_ re.loop 3 3) (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
