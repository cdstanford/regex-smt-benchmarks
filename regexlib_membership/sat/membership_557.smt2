;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(192\.168\.[0-9]|[1-9][0-9]|[1-2][0-5][0-5]\.[0-9]|[1-9][0-9]|[1-2][0-5][0-5])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "192.168.3"
(define-fun Witness1 () String (str.++ "1" (str.++ "9" (str.++ "2" (str.++ "." (str.++ "1" (str.++ "6" (str.++ "8" (str.++ "." (str.++ "3" ""))))))))))
;witness2: "92"
(define-fun Witness2 () String (str.++ "9" (str.++ "2" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (str.++ "1" (str.++ "9" (str.++ "2" (str.++ "." (str.++ "1" (str.++ "6" (str.++ "8" (str.++ "." ""))))))))) (re.range "0" "9"))(re.union (re.++ (re.range "1" "9") (re.range "0" "9"))(re.union (re.++ (re.range "1" "2")(re.++ (re.range "0" "5")(re.++ (re.range "0" "5")(re.++ (re.range "." ".") (re.range "0" "9")))))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.++ (re.range "1" "2")(re.++ (re.range "0" "5") (re.range "0" "5"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
