;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d|\d{1,9}|1\d{1,9}|20\d{8}|213\d{7}|2146\d{6}|21473\d{5}|214747\d{4}|2147482\d{3}|21474835\d{2}|214748364[0-7])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "2147482899"
(define-fun Witness1 () String (str.++ "2" (str.++ "1" (str.++ "4" (str.++ "7" (str.++ "4" (str.++ "8" (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "9" "")))))))))))
;witness2: "14"
(define-fun Witness2 () String (str.++ "1" (str.++ "4" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union ((_ re.loop 1 9) (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") ((_ re.loop 1 9) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "0" ""))) ((_ re.loop 8 8) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "1" (str.++ "3" "")))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "1" (str.++ "4" (str.++ "6" ""))))) ((_ re.loop 6 6) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "1" (str.++ "4" (str.++ "7" (str.++ "3" "")))))) ((_ re.loop 5 5) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "1" (str.++ "4" (str.++ "7" (str.++ "4" (str.++ "7" ""))))))) ((_ re.loop 4 4) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "1" (str.++ "4" (str.++ "7" (str.++ "4" (str.++ "8" (str.++ "2" "")))))))) ((_ re.loop 3 3) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "1" (str.++ "4" (str.++ "7" (str.++ "4" (str.++ "8" (str.++ "3" (str.++ "5" ""))))))))) ((_ re.loop 2 2) (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "1" (str.++ "4" (str.++ "7" (str.++ "4" (str.++ "8" (str.++ "3" (str.++ "6" (str.++ "4" "")))))))))) (re.range "0" "7")))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
