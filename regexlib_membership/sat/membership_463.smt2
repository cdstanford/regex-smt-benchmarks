;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(429496729[0-6]|42949672[0-8]\d|4294967[01]\d{2}|429496[0-6]\d{3}|42949[0-5]\d{4}|4294[0-8]\d{5}|429[0-3]\d{6}|42[0-8]\d{7}|4[01]\d{8}|[1-3]\d{9}|[1-9]\d{8}|[1-9]\d{7}|[1-9]\d{6}|[1-9]\d{5}|[1-9]\d{4}|[1-9]\d{3}|[1-9]\d{2}|[1-9]\d|\d)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "4150084838"
(define-fun Witness1 () String (str.++ "4" (str.++ "1" (str.++ "5" (str.++ "0" (str.++ "0" (str.++ "8" (str.++ "4" (str.++ "8" (str.++ "3" (str.++ "8" "")))))))))))
;witness2: "898"
(define-fun Witness2 () String (str.++ "8" (str.++ "9" (str.++ "8" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (str.++ "4" (str.++ "2" (str.++ "9" (str.++ "4" (str.++ "9" (str.++ "6" (str.++ "7" (str.++ "2" (str.++ "9" "")))))))))) (re.range "0" "6"))(re.union (re.++ (str.to_re (str.++ "4" (str.++ "2" (str.++ "9" (str.++ "4" (str.++ "9" (str.++ "6" (str.++ "7" (str.++ "2" "")))))))))(re.++ (re.range "0" "8") (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "4" (str.++ "2" (str.++ "9" (str.++ "4" (str.++ "9" (str.++ "6" (str.++ "7" ""))))))))(re.++ (re.range "0" "1") ((_ re.loop 2 2) (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "4" (str.++ "2" (str.++ "9" (str.++ "4" (str.++ "9" (str.++ "6" "")))))))(re.++ (re.range "0" "6") ((_ re.loop 3 3) (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "4" (str.++ "2" (str.++ "9" (str.++ "4" (str.++ "9" ""))))))(re.++ (re.range "0" "5") ((_ re.loop 4 4) (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "4" (str.++ "2" (str.++ "9" (str.++ "4" "")))))(re.++ (re.range "0" "8") ((_ re.loop 5 5) (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "4" (str.++ "2" (str.++ "9" ""))))(re.++ (re.range "0" "3") ((_ re.loop 6 6) (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "4" (str.++ "2" "")))(re.++ (re.range "0" "8") ((_ re.loop 7 7) (re.range "0" "9"))))(re.union (re.++ (re.range "4" "4")(re.++ (re.range "0" "1") ((_ re.loop 8 8) (re.range "0" "9"))))(re.union (re.++ (re.range "1" "3") ((_ re.loop 9 9) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") ((_ re.loop 8 8) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") ((_ re.loop 6 6) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") ((_ re.loop 5 5) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") ((_ re.loop 4 4) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") ((_ re.loop 3 3) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9"))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
