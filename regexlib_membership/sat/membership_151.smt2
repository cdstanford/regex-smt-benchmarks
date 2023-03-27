;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+|-)?(\d\.\d{1,6}|[1-9]\d\.\d{1,6}|1[1-7]\d\.\d{1,6}|180\.0{1,6})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "83.0"
(define-fun Witness1 () String (str.++ "8" (str.++ "3" (str.++ "." (str.++ "0" "")))))
;witness2: "-180.0"
(define-fun Witness2 () String (str.++ "-" (str.++ "1" (str.++ "8" (str.++ "0" (str.++ "." (str.++ "0" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.union (re.++ (re.range "0" "9")(re.++ (re.range "." ".") ((_ re.loop 1 6) (re.range "0" "9"))))(re.union (re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.range "." ".") ((_ re.loop 1 6) (re.range "0" "9")))))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "1" "7")(re.++ (re.range "0" "9")(re.++ (re.range "." ".") ((_ re.loop 1 6) (re.range "0" "9")))))) (re.++ (str.to_re (str.++ "1" (str.++ "8" (str.++ "0" (str.++ "." ""))))) ((_ re.loop 1 6) (re.range "0" "0")))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
