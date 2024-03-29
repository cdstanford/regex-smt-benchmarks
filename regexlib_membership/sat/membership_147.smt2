;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((2[0-5][0-5]|1[\d][\d]|[\d][\d]|[\d])\.){3}(2[0-5][0-5]|1[\d][\d]|[\d][\d]|[\d])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "169.180.111.0"
(define-fun Witness1 () String (str.++ "1" (str.++ "6" (str.++ "9" (str.++ "." (str.++ "1" (str.++ "8" (str.++ "0" (str.++ "." (str.++ "1" (str.++ "1" (str.++ "1" (str.++ "." (str.++ "0" ""))))))))))))))
;witness2: "214.23.214.9"
(define-fun Witness2 () String (str.++ "2" (str.++ "1" (str.++ "4" (str.++ "." (str.++ "2" (str.++ "3" (str.++ "." (str.++ "2" (str.++ "1" (str.++ "4" (str.++ "." (str.++ "9" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.++ (re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "5") (re.range "0" "5")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "0" "9") (re.range "0" "9")) (re.range "0" "9")))) (re.range "." ".")))(re.++ (re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "5") (re.range "0" "5")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "0" "9") (re.range "0" "9")) (re.range "0" "9")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
