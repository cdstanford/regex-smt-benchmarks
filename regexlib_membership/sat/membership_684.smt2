;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((4(\d{12}|\d{15}))|(5\d{15})|(6011\d{12})|(3(4|7)\d{13}))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "5749892409821904"
(define-fun Witness1 () String (str.++ "5" (str.++ "7" (str.++ "4" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "2" (str.++ "4" (str.++ "0" (str.++ "9" (str.++ "8" (str.++ "2" (str.++ "1" (str.++ "9" (str.++ "0" (str.++ "4" "")))))))))))))))))
;witness2: "346569208808149"
(define-fun Witness2 () String (str.++ "3" (str.++ "4" (str.++ "6" (str.++ "5" (str.++ "6" (str.++ "9" (str.++ "2" (str.++ "0" (str.++ "8" (str.++ "8" (str.++ "0" (str.++ "8" (str.++ "1" (str.++ "4" (str.++ "9" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "4" "4") (re.union ((_ re.loop 12 12) (re.range "0" "9")) ((_ re.loop 15 15) (re.range "0" "9"))))(re.union (re.++ (re.range "5" "5") ((_ re.loop 15 15) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "6" (str.++ "0" (str.++ "1" (str.++ "1" ""))))) ((_ re.loop 12 12) (re.range "0" "9"))) (re.++ (re.range "3" "3")(re.++ (re.union (re.range "4" "4") (re.range "7" "7")) ((_ re.loop 13 13) (re.range "0" "9"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
