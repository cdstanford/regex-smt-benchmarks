;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0][5][0]-\d{7}|[0][5][2]-\d{7}|[0][5][4]-\d{7}|[0][5][7]-\d{7}|[0][7][7]-\d{7}|[0][2]-\d{7}|[0][3]-\d{7}|[0][4]-\d{7}|[0][8]-\d{7}|[0][9]-\d{7}|[0][5][0]\d{7}|[0][5][2]\d{7}|[0][5][4]\d{7}|[0][5][7]\d{7}|[0][7][7]\d{7}|[0][2]\d{7}|[0][3]\d{7}|[0][4]\d{7}|[0][8]\d{7}|[0][9]\d{7}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "050-6859898\u0099"
(define-fun Witness1 () String (str.++ "0" (str.++ "5" (str.++ "0" (str.++ "-" (str.++ "6" (str.++ "8" (str.++ "5" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "\u{99}" "")))))))))))))
;witness2: "0520865997"
(define-fun Witness2 () String (str.++ "0" (str.++ "5" (str.++ "2" (str.++ "0" (str.++ "8" (str.++ "6" (str.++ "5" (str.++ "9" (str.++ "9" (str.++ "7" "")))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "0" (str.++ "5" (str.++ "0" (str.++ "-" ""))))) ((_ re.loop 7 7) (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "5" (str.++ "2" (str.++ "-" ""))))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "5" (str.++ "4" (str.++ "-" ""))))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "5" (str.++ "7" (str.++ "-" ""))))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "7" (str.++ "7" (str.++ "-" ""))))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "2" (str.++ "-" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "3" (str.++ "-" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "4" (str.++ "-" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "8" (str.++ "-" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "9" (str.++ "-" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "5" (str.++ "0" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "5" (str.++ "2" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "5" (str.++ "4" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "5" (str.++ "7" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "7" (str.++ "7" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "2" ""))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "3" ""))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "4" ""))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "8" ""))) ((_ re.loop 7 7) (re.range "0" "9"))) (re.++ (str.to_re (str.++ "0" (str.++ "9" "")))(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re ""))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
