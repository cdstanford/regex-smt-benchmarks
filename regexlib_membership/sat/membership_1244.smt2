;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([30|36|38]{2})([0-9]{12})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "06600610899932"
(define-fun Witness1 () String (str.++ "0" (str.++ "6" (str.++ "6" (str.++ "0" (str.++ "0" (str.++ "6" (str.++ "1" (str.++ "0" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "3" (str.++ "2" "")))))))))))))))
;witness2: "|6998999980987"
(define-fun Witness2 () String (str.++ "|" (str.++ "6" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "9" (str.++ "8" (str.++ "7" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6")(re.union (re.range "8" "8") (re.range "|" "|"))))))(re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
