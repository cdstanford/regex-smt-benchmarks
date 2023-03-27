;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(00[1-9]|0[1-9][0-9]|[1-6][0-9][0-9]|7[0-6][0-9]|77[0-2]\-\d{2}\-\d{4})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "740"
(define-fun Witness1 () String (str.++ "7" (str.++ "4" (str.++ "0" ""))))
;witness2: "679"
(define-fun Witness2 () String (str.++ "6" (str.++ "7" (str.++ "9" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (str.++ "0" (str.++ "0" ""))) (re.range "1" "9"))(re.union (re.++ (re.range "0" "0")(re.++ (re.range "1" "9") (re.range "0" "9")))(re.union (re.++ (re.range "1" "6")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "7" "7")(re.++ (re.range "0" "6") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "7" (str.++ "7" "")))(re.++ (re.range "0" "2")(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9"))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
