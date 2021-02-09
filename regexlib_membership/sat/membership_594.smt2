;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0][5][0]-\d{7}|[0][5][2]-\d{7}|[0][5][4]-\d{7}|[0][5][7]-\d{7}|[0][7][7]-\d{7}|[0][2]-\d{7}|[0][3]-\d{7}|[0][4]-\d{7}|[0][8]-\d{7}|[0][9]-\d{7}|[0][5][0]\d{7}|[0][5][2]\d{7}|[0][5][4]\d{7}|[0][5][7]\d{7}|[0][7][7]\d{7}|[0][2]\d{7}|[0][3]\d{7}|[0][4]\d{7}|[0][8]\d{7}|[0][9]\d{7}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "050-6859898\u0099"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "5" (seq.++ "0" (seq.++ "-" (seq.++ "6" (seq.++ "8" (seq.++ "5" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "\x99" "")))))))))))))
;witness2: "0520865997"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "5" (seq.++ "2" (seq.++ "0" (seq.++ "8" (seq.++ "6" (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ "7" "")))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "0" (seq.++ "5" (seq.++ "0" (seq.++ "-" ""))))) ((_ re.loop 7 7) (re.range "0" "9"))))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "5" (seq.++ "2" (seq.++ "-" ""))))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "5" (seq.++ "4" (seq.++ "-" ""))))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "5" (seq.++ "7" (seq.++ "-" ""))))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "7" (seq.++ "7" (seq.++ "-" ""))))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "2" (seq.++ "-" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "3" (seq.++ "-" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "4" (seq.++ "-" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "8" (seq.++ "-" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "9" (seq.++ "-" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "5" (seq.++ "0" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "5" (seq.++ "2" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "5" (seq.++ "4" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "5" (seq.++ "7" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "7" (seq.++ "7" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "2" ""))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "3" ""))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "4" ""))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "8" ""))) ((_ re.loop 7 7) (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "0" (seq.++ "9" "")))(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re ""))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
