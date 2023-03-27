;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0,1]?\d{1}\/(([0-2]?\d{1})|([3][0,1]{1}))\/(([1]{1}[9]{1}[9]{1}\d{1})|([2-9]{1}\d{3}))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0/9/1995"
(define-fun Witness1 () String (str.++ "0" (str.++ "/" (str.++ "9" (str.++ "/" (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "5" "")))))))))
;witness2: "8/12/1995"
(define-fun Witness2 () String (str.++ "8" (str.++ "/" (str.++ "1" (str.++ "2" (str.++ "/" (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "5" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "," ",") (re.range "0" "1")))(re.++ (re.range "0" "9")(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.opt (re.range "0" "2")) (re.range "0" "9")) (re.++ (re.range "3" "3") (re.union (re.range "," ",") (re.range "0" "1"))))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (str.to_re (str.++ "1" (str.++ "9" (str.++ "9" "")))) (re.range "0" "9")) (re.++ (re.range "2" "9") ((_ re.loop 3 3) (re.range "0" "9")))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
