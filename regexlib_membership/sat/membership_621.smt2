;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((00|\+)49)?(0?1[5-7][0-9]{1,})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+490155"
(define-fun Witness1 () String (str.++ "+" (str.++ "4" (str.++ "9" (str.++ "0" (str.++ "1" (str.++ "5" (str.++ "5" ""))))))))
;witness2: "00490159"
(define-fun Witness2 () String (str.++ "0" (str.++ "0" (str.++ "4" (str.++ "9" (str.++ "0" (str.++ "1" (str.++ "5" (str.++ "9" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.union (str.to_re (str.++ "0" (str.++ "0" ""))) (re.range "+" "+")) (str.to_re (str.++ "4" (str.++ "9" "")))))(re.++ (re.++ (re.opt (re.range "0" "0"))(re.++ (re.range "1" "1")(re.++ (re.range "5" "7") (re.+ (re.range "0" "9"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
