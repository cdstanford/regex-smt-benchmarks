;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((([7-9])(\d{3})([-])(\d{4}))|(([7-9])(\d{7})))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "7998-8199"
(define-fun Witness1 () String (str.++ "7" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "-" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "9" ""))))))))))
;witness2: "7565-0307\u00C1\""
(define-fun Witness2 () String (str.++ "7" (str.++ "5" (str.++ "6" (str.++ "5" (str.++ "-" (str.++ "0" (str.++ "3" (str.++ "0" (str.++ "7" (str.++ "\u{c1}" (str.++ "\u{22}" ""))))))))))))

(assert (= regexA (re.union (re.++ (re.range "7" "9")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9"))))) (re.++ (re.range "7" "9") ((_ re.loop 7 7) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
