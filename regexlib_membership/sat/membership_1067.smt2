;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(0|([1-9]\d{0,3}|[1-5]\d{4}|[6][0-5][0-5]([0-2]\d|[3][0-5])))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "18253"
(define-fun Witness1 () String (str.++ "1" (str.++ "8" (str.++ "2" (str.++ "5" (str.++ "3" ""))))))
;witness2: "0"
(define-fun Witness2 () String (str.++ "0" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "0") (re.union (re.++ (re.range "1" "9") ((_ re.loop 0 3) (re.range "0" "9")))(re.union (re.++ (re.range "1" "5") ((_ re.loop 4 4) (re.range "0" "9"))) (re.++ (re.range "6" "6")(re.++ (re.range "0" "5")(re.++ (re.range "0" "5") (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "5"))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
