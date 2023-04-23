;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\d{5}-\d{3}|^\d{2}.\d{3}-\d{3}|\d{8})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "72374379x"
(define-fun Witness1 () String (str.++ "7" (str.++ "2" (str.++ "3" (str.++ "7" (str.++ "4" (str.++ "3" (str.++ "7" (str.++ "9" (str.++ "x" ""))))))))))
;witness2: "56849-347"
(define-fun Witness2 () String (str.++ "5" (str.++ "6" (str.++ "8" (str.++ "4" (str.++ "9" (str.++ "-" (str.++ "3" (str.++ "4" (str.++ "7" ""))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 3 3) (re.range "0" "9")))))(re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 3 3) (re.range "0" "9"))))))) ((_ re.loop 8 8) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
