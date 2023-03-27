;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(\d{2}.\d{3}.\d{3}/\d{4}-\d{2})|(\d{14})$)|(^(\d{3}.\d{3}.\d{3}-\d{2})|(\d{11})$)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "k51245127919804"
(define-fun Witness1 () String (str.++ "k" (str.++ "5" (str.++ "1" (str.++ "2" (str.++ "4" (str.++ "5" (str.++ "1" (str.++ "2" (str.++ "7" (str.++ "9" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "4" ""))))))))))))))))
;witness2: "F\u008D\x15\u0087\u00A1\u00B085389440484"
(define-fun Witness2 () String (str.++ "F" (str.++ "\u{8d}" (str.++ "\u{15}" (str.++ "\u{87}" (str.++ "\u{a1}" (str.++ "\u{b0}" (str.++ "8" (str.++ "5" (str.++ "3" (str.++ "8" (str.++ "9" (str.++ "4" (str.++ "4" (str.++ "0" (str.++ "4" (str.++ "8" (str.++ "4" ""))))))))))))))))))

(assert (= regexA (re.union (re.union (re.++ (str.to_re "") (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "/" "/")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9"))))))))))) (re.++ ((_ re.loop 14 14) (re.range "0" "9")) (str.to_re ""))) (re.union (re.++ (str.to_re "") (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9"))))))))) (re.++ ((_ re.loop 11 11) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
