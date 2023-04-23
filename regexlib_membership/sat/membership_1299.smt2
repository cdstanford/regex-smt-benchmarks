;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(\d{3}.\d{3}.\d{3}-\d{2})|(\d{11})$)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "386D385\u00BE939-69"
(define-fun Witness1 () String (str.++ "3" (str.++ "8" (str.++ "6" (str.++ "D" (str.++ "3" (str.++ "8" (str.++ "5" (str.++ "\u{be}" (str.++ "9" (str.++ "3" (str.++ "9" (str.++ "-" (str.++ "6" (str.++ "9" "")))))))))))))))
;witness2: "A92495984481"
(define-fun Witness2 () String (str.++ "A" (str.++ "9" (str.++ "2" (str.++ "4" (str.++ "9" (str.++ "5" (str.++ "9" (str.++ "8" (str.++ "4" (str.++ "4" (str.++ "8" (str.++ "1" "")))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9"))))))))) (re.++ ((_ re.loop 11 11) (re.range "0" "9")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
