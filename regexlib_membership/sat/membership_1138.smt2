;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(4915[0-1]|491[0-4]\d|490\d\d|4[0-8]\d{3}|[1-3]\d{4}|[2-9]\d{3}|1[1-9]\d{2}|10[3-9]\d|102[4-9])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1026"
(define-fun Witness1 () String (str.++ "1" (str.++ "0" (str.++ "2" (str.++ "6" "")))))
;witness2: "13949"
(define-fun Witness2 () String (str.++ "1" (str.++ "3" (str.++ "9" (str.++ "4" (str.++ "9" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (str.++ "4" (str.++ "9" (str.++ "1" (str.++ "5" ""))))) (re.range "0" "1"))(re.union (re.++ (str.to_re (str.++ "4" (str.++ "9" (str.++ "1" ""))))(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "4" (str.++ "9" (str.++ "0" ""))))(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "4" "4")(re.++ (re.range "0" "8") ((_ re.loop 3 3) (re.range "0" "9"))))(re.union (re.++ (re.range "1" "3") ((_ re.loop 4 4) (re.range "0" "9")))(re.union (re.++ (re.range "2" "9") ((_ re.loop 3 3) (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "1" "9") ((_ re.loop 2 2) (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "0" "")))(re.++ (re.range "3" "9") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "1" (str.++ "0" (str.++ "2" "")))) (re.range "4" "9")))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
