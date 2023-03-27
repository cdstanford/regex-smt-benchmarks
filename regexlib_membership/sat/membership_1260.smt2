;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((?:2[0-5]{2}|1\d{2}|[1-9]\d|[1-9])\.(?:(?:2[0-5]{2}|1\d{2}|[1-9]\d|\d)\.){2}(?:2[0-5]{2}|1\d{2}|[1-9]\d|\d)):(\d|[1-9]\d|[1-9]\d{2,3}|[1-5]\d{4}|6[0-4]\d{3}|654\d{2}|655[0-2]\d|6553[0-5])$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "124.154.9.240:88"
(define-fun Witness1 () String (str.++ "1" (str.++ "2" (str.++ "4" (str.++ "." (str.++ "1" (str.++ "5" (str.++ "4" (str.++ "." (str.++ "9" (str.++ "." (str.++ "2" (str.++ "4" (str.++ "0" (str.++ ":" (str.++ "8" (str.++ "8" "")))))))))))))))))
;witness2: "12.90.193.255:65439"
(define-fun Witness2 () String (str.++ "1" (str.++ "2" (str.++ "." (str.++ "9" (str.++ "0" (str.++ "." (str.++ "1" (str.++ "9" (str.++ "3" (str.++ "." (str.++ "2" (str.++ "5" (str.++ "5" (str.++ ":" (str.++ "6" (str.++ "5" (str.++ "4" (str.++ "3" (str.++ "9" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.++ (re.range "2" "2") ((_ re.loop 2 2) (re.range "0" "5")))(re.union (re.++ (re.range "1" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "1" "9"))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 2) (re.++ (re.union (re.++ (re.range "2" "2") ((_ re.loop 2 2) (re.range "0" "5")))(re.union (re.++ (re.range "1" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9")))) (re.range "." "."))) (re.union (re.++ (re.range "2" "2") ((_ re.loop 2 2) (re.range "0" "5")))(re.union (re.++ (re.range "1" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9")))))))(re.++ (re.range ":" ":")(re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "1" "9") (re.range "0" "9"))(re.union (re.++ (re.range "1" "9") ((_ re.loop 2 3) (re.range "0" "9")))(re.union (re.++ (re.range "1" "5") ((_ re.loop 4 4) (re.range "0" "9")))(re.union (re.++ (re.range "6" "6")(re.++ (re.range "0" "4") ((_ re.loop 3 3) (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "6" (str.++ "5" (str.++ "4" "")))) ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "6" (str.++ "5" (str.++ "5" ""))))(re.++ (re.range "0" "2") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "6" (str.++ "5" (str.++ "5" (str.++ "3" ""))))) (re.range "0" "5"))))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
