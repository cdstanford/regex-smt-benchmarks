;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(0[1-9]|1[0-2])\/((0[1-9]|2\d)|3[0-1])\/(19\d\d|200[0-3])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "12/23/1998"
(define-fun Witness1 () String (str.++ "1" (str.++ "2" (str.++ "/" (str.++ "2" (str.++ "3" (str.++ "/" (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "8" "")))))))))))
;witness2: "12/31/2001"
(define-fun Witness2 () String (str.++ "1" (str.++ "2" (str.++ "/" (str.++ "3" (str.++ "1" (str.++ "/" (str.++ "2" (str.++ "0" (str.++ "0" (str.++ "1" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "/" "/")(re.++ (re.union (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "2" "2") (re.range "0" "9"))) (re.++ (re.range "3" "3") (re.range "0" "1")))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (str.to_re (str.++ "1" (str.++ "9" "")))(re.++ (re.range "0" "9") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "0" (str.++ "0" "")))) (re.range "0" "3"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
