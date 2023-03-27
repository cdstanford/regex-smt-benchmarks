;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{2}-\d{2})*$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "57-8894-1234-96"
(define-fun Witness1 () String (str.++ "5" (str.++ "7" (str.++ "-" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "4" (str.++ "-" (str.++ "1" (str.++ "2" (str.++ "3" (str.++ "4" (str.++ "-" (str.++ "9" (str.++ "6" ""))))))))))))))))
;witness2: "99-8949-8099-2852-0993-89"
(define-fun Witness2 () String (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "8" (str.++ "9" (str.++ "4" (str.++ "9" (str.++ "-" (str.++ "8" (str.++ "0" (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "2" (str.++ "8" (str.++ "5" (str.++ "2" (str.++ "-" (str.++ "0" (str.++ "9" (str.++ "9" (str.++ "3" (str.++ "-" (str.++ "8" (str.++ "9" ""))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
