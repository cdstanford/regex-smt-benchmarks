;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =        |104[0-7]\d{3}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1045959\u0097"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "0" (seq.++ "4" (seq.++ "5" (seq.++ "9" (seq.++ "5" (seq.++ "9" (seq.++ "\x97" "")))))))))
;witness2: "       "
(define-fun Witness2 () String (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " ""))))))))

(assert (= regexA (re.union (str.to_re (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " "")))))))) (re.++ (str.to_re (seq.++ "1" (seq.++ "0" (seq.++ "4" ""))))(re.++ (re.range "0" "7") ((_ re.loop 3 3) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
