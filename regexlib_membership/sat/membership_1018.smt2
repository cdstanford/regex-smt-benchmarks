;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(IE){0,1}[0-9][0-9A-Z\+\*][0-9]{5}[A-Z]$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9980319O"
(define-fun Witness1 () String (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "3" (str.++ "1" (str.++ "9" (str.++ "O" "")))))))))
;witness2: "IE6+99974J"
(define-fun Witness2 () String (str.++ "I" (str.++ "E" (str.++ "6" (str.++ "+" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "7" (str.++ "4" (str.++ "J" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (str.++ "I" (str.++ "E" ""))))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "*" "+")(re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.range "A" "Z") (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
