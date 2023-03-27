;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]{2}-[0-9]{8}-[0-9]$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "46-54528984-8"
(define-fun Witness1 () String (str.++ "4" (str.++ "6" (str.++ "-" (str.++ "5" (str.++ "4" (str.++ "5" (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "4" (str.++ "-" (str.++ "8" ""))))))))))))))
;witness2: "48-50399079-7"
(define-fun Witness2 () String (str.++ "4" (str.++ "8" (str.++ "-" (str.++ "5" (str.++ "0" (str.++ "3" (str.++ "9" (str.++ "9" (str.++ "0" (str.++ "7" (str.++ "9" (str.++ "-" (str.++ "7" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 8 8) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.range "0" "9") (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
