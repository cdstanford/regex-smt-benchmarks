;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^[1]$)|(^[1]+\d*\.+\d*[1-5]$)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1"
(define-fun Witness1 () String (str.++ "1" ""))
;witness2: "111199.4"
(define-fun Witness2 () String (str.++ "1" (str.++ "1" (str.++ "1" (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "." (str.++ "4" "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "1" "1") (str.to_re ""))) (re.++ (str.to_re "")(re.++ (re.+ (re.range "1" "1"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.+ (re.range "." "."))(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "1" "5") (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
