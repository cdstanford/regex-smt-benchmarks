;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(X(-|\.)?0?\d{7}(-|\.)?[A-Z]|[A-Z](-|\.)?\d{7}(-|\.)?[0-9A-Z]|\d{8}(-|\.)?[A-Z])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "58967888-Y"
(define-fun Witness1 () String (str.++ "5" (str.++ "8" (str.++ "9" (str.++ "6" (str.++ "7" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "-" (str.++ "Y" "")))))))))))
;witness2: "A-9811899R"
(define-fun Witness2 () String (str.++ "A" (str.++ "-" (str.++ "9" (str.++ "8" (str.++ "1" (str.++ "1" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "R" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "X" "X")(re.++ (re.opt (re.range "-" "."))(re.++ (re.opt (re.range "0" "0"))(re.++ ((_ re.loop 7 7) (re.range "0" "9"))(re.++ (re.opt (re.range "-" ".")) (re.range "A" "Z"))))))(re.union (re.++ (re.range "A" "Z")(re.++ (re.opt (re.range "-" "."))(re.++ ((_ re.loop 7 7) (re.range "0" "9"))(re.++ (re.opt (re.range "-" ".")) (re.union (re.range "0" "9") (re.range "A" "Z")))))) (re.++ ((_ re.loop 8 8) (re.range "0" "9"))(re.++ (re.opt (re.range "-" ".")) (re.range "A" "Z"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
