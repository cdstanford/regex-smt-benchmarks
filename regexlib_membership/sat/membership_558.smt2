;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(172\.1[6-9]|2[0-9]|3[0-1|\.[0-9]|[1-9][0-9]|[1-2][0-5][0-5]\.[0-9]|[1-9][0-9]|[1-2][0-5][0-5])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "3."
(define-fun Witness1 () String (str.++ "3" (str.++ "." "")))
;witness2: "133.5"
(define-fun Witness2 () String (str.++ "1" (str.++ "3" (str.++ "3" (str.++ "." (str.++ "5" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (str.++ "1" (str.++ "7" (str.++ "2" (str.++ "." (str.++ "1" "")))))) (re.range "6" "9"))(re.union (re.++ (re.range "2" "2") (re.range "0" "9"))(re.union (re.++ (re.range "3" "3") (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "[" "[") (re.range "|" "|")))))(re.union (re.++ (re.range "1" "9") (re.range "0" "9"))(re.union (re.++ (re.range "1" "2")(re.++ (re.range "0" "5")(re.++ (re.range "0" "5")(re.++ (re.range "." ".") (re.range "0" "9")))))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.++ (re.range "1" "2")(re.++ (re.range "0" "5") (re.range "0" "5"))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
