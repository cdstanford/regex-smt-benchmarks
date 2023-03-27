;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[1-9]{1}[0-9]{3}-(0[1-9]{1}|1[0-2]{1})-([0-2]{1}[1-9]{1}|3[0-1]{1}) ([0-1]{1}[0-9]{1}|2[0-3]{1}):[0-5]{1}[0-9]{1}:[0-5]{1}[0-9]{1}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "6416-07-31 23:38:45"
(define-fun Witness1 () String (str.++ "6" (str.++ "4" (str.++ "1" (str.++ "6" (str.++ "-" (str.++ "0" (str.++ "7" (str.++ "-" (str.++ "3" (str.++ "1" (str.++ " " (str.++ "2" (str.++ "3" (str.++ ":" (str.++ "3" (str.++ "8" (str.++ ":" (str.++ "4" (str.++ "5" ""))))))))))))))))))))
;witness2: "3815-02-21 22:45:59"
(define-fun Witness2 () String (str.++ "3" (str.++ "8" (str.++ "1" (str.++ "5" (str.++ "-" (str.++ "0" (str.++ "2" (str.++ "-" (str.++ "2" (str.++ "1" (str.++ " " (str.++ "2" (str.++ "2" (str.++ ":" (str.++ "4" (str.++ "5" (str.++ ":" (str.++ "5" (str.++ "9" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "1" "9")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "2") (re.range "1" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))(re.++ (re.range " " " ")(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9") (str.to_re ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
