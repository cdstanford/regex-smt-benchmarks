;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [1-2][0|9][0-9]{2}[0-1][0-9][0-3][0-9][-][0-9]{4}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "10891928-7268"
(define-fun Witness1 () String (str.++ "1" (str.++ "0" (str.++ "8" (str.++ "9" (str.++ "1" (str.++ "9" (str.++ "2" (str.++ "8" (str.++ "-" (str.++ "7" (str.++ "2" (str.++ "6" (str.++ "8" ""))))))))))))))
;witness2: "1|491838-9019"
(define-fun Witness2 () String (str.++ "1" (str.++ "|" (str.++ "4" (str.++ "9" (str.++ "1" (str.++ "8" (str.++ "3" (str.++ "8" (str.++ "-" (str.++ "9" (str.++ "0" (str.++ "1" (str.++ "9" ""))))))))))))))

(assert (= regexA (re.++ (re.range "1" "2")(re.++ (re.union (re.range "0" "0")(re.union (re.range "9" "9") (re.range "|" "|")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "0" "1")(re.++ (re.range "0" "9")(re.++ (re.range "0" "3")(re.++ (re.range "0" "9")(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
