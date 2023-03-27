;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[1-9]\d?-\d{7}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "28-9985999"
(define-fun Witness1 () String (str.++ "2" (str.++ "8" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "5" (str.++ "9" (str.++ "9" (str.++ "9" "")))))))))))
;witness2: "8-6507902"
(define-fun Witness2 () String (str.++ "8" (str.++ "-" (str.++ "6" (str.++ "5" (str.++ "0" (str.++ "7" (str.++ "9" (str.++ "0" (str.++ "2" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "1" "9")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
