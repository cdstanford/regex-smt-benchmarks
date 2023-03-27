;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =        |1048[0-4]\d\d
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "       "
(define-fun Witness1 () String (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " ""))))))))
;witness2: "       "
(define-fun Witness2 () String (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " ""))))))))

(assert (= regexA (re.union (str.to_re (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " "")))))))) (re.++ (str.to_re (str.++ "1" (str.++ "0" (str.++ "4" (str.++ "8" "")))))(re.++ (re.range "0" "4")(re.++ (re.range "0" "9") (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
