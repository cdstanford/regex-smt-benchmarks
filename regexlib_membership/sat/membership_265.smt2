;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z]{1}-[0-9]{7}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "C-4988685"
(define-fun Witness1 () String (str.++ "C" (str.++ "-" (str.++ "4" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "6" (str.++ "8" (str.++ "5" ""))))))))))
;witness2: "H-3299307"
(define-fun Witness2 () String (str.++ "H" (str.++ "-" (str.++ "3" (str.++ "2" (str.++ "9" (str.++ "9" (str.++ "3" (str.++ "0" (str.++ "7" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "A" "Z")(re.++ (re.range "-" "-")(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
