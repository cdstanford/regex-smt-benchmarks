;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "238.9.86.98"
(define-fun Witness1 () String (str.++ "2" (str.++ "3" (str.++ "8" (str.++ "." (str.++ "9" (str.++ "." (str.++ "8" (str.++ "6" (str.++ "." (str.++ "9" (str.++ "8" ""))))))))))))
;witness2: "181.189.247.199"
(define-fun Witness2 () String (str.++ "1" (str.++ "8" (str.++ "1" (str.++ "." (str.++ "1" (str.++ "8" (str.++ "9" (str.++ "." (str.++ "2" (str.++ "4" (str.++ "7" (str.++ "." (str.++ "1" (str.++ "9" (str.++ "9" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union ((_ re.loop 1 2) (re.range "0" "9"))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5")))))(re.++ (re.range "." ".")(re.++ (re.union ((_ re.loop 1 2) (re.range "0" "9"))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5")))))(re.++ (re.range "." ".")(re.++ (re.union ((_ re.loop 1 2) (re.range "0" "9"))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5")))))(re.++ (re.range "." ".")(re.++ (re.union ((_ re.loop 1 2) (re.range "0" "9"))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
