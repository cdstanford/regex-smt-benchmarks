;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =       ([\dA-F]){1,5}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u008A      A"
(define-fun Witness1 () String (str.++ "\u{8a}" (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ "A" "")))))))))
;witness2: "      2\u00CB"
(define-fun Witness2 () String (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ "2" (str.++ "\u{cb}" "")))))))))

(assert (= regexA (re.++ (str.to_re (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ " " ""))))))) ((_ re.loop 1 5) (re.union (re.range "0" "9") (re.range "A" "F"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
