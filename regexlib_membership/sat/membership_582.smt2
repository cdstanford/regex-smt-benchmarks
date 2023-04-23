;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((0[0-9])|(1[0-2])|(2[1-9])|(3[0-2])|(6[1-9])|(7[0-2])|80)([0-9]{7})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "295499978"
(define-fun Witness1 () String (str.++ "2" (str.++ "9" (str.++ "5" (str.++ "4" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "7" (str.++ "8" ""))))))))))
;witness2: "324878283"
(define-fun Witness2 () String (str.++ "3" (str.++ "2" (str.++ "4" (str.++ "8" (str.++ "7" (str.++ "8" (str.++ "2" (str.++ "8" (str.++ "3" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "2"))(re.union (re.++ (re.range "2" "2") (re.range "1" "9"))(re.union (re.++ (re.range "3" "3") (re.range "0" "2"))(re.union (re.++ (re.range "6" "6") (re.range "1" "9"))(re.union (re.++ (re.range "7" "7") (re.range "0" "2")) (str.to_re (str.++ "8" (str.++ "0" "")))))))))(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
