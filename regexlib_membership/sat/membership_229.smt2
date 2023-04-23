;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(0?[1-9]|1[0-2])\/(0?[1-9]|[1-2][0-9]|3[0-1])\/(0[1-9]|[1-9][0-9]|175[3-9]|17[6-9][0-9]|1[8-9][0-9]{2}|[2-9][0-9]{3})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "11/01/01"
(define-fun Witness1 () String (str.++ "1" (str.++ "1" (str.++ "/" (str.++ "0" (str.++ "1" (str.++ "/" (str.++ "0" (str.++ "1" "")))))))))
;witness2: "5/1/1765"
(define-fun Witness2 () String (str.++ "5" (str.++ "/" (str.++ "1" (str.++ "/" (str.++ "1" (str.++ "7" (str.++ "6" (str.++ "5" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "9") (re.range "0" "9"))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "7" (str.++ "5" "")))) (re.range "3" "9"))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "7" "")))(re.++ (re.range "6" "9") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "8" "9") ((_ re.loop 2 2) (re.range "0" "9")))) (re.++ (re.range "2" "9") ((_ re.loop 3 3) (re.range "0" "9")))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
