;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([1-9]{1}[0-9]{3}[,]?)*([1-9]{1}[0-9]{3})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "3940"
(define-fun Witness1 () String (str.++ "3" (str.++ "9" (str.++ "4" (str.++ "0" "")))))
;witness2: "70888210"
(define-fun Witness2 () String (str.++ "7" (str.++ "0" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "2" (str.++ "1" (str.++ "0" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ (re.range "1" "9")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range "," ",")))))(re.++ (re.++ (re.range "1" "9") ((_ re.loop 3 3) (re.range "0" "9"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
