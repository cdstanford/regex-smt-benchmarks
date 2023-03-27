;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(\d{2}.\d{3}.\d{3}/\d{4}-\d{2})|(\d{14})$)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "69982134889774"
(define-fun Witness1 () String (str.++ "6" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "2" (str.++ "1" (str.++ "3" (str.++ "4" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "7" (str.++ "7" (str.++ "4" "")))))))))))))))
;witness2: "\u00F070898864152268"
(define-fun Witness2 () String (str.++ "\u{f0}" (str.++ "7" (str.++ "0" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "6" (str.++ "4" (str.++ "1" (str.++ "5" (str.++ "2" (str.++ "2" (str.++ "6" (str.++ "8" ""))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "/" "/")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9"))))))))))) (re.++ ((_ re.loop 14 14) (re.range "0" "9")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
