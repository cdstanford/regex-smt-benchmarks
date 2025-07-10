;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\(\d{3,4}\)|\d{3,4}-)\d{4,9}(-\d{1,5}|\d{0}))|(\d{4,12})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00E6p(198)8988994"
(define-fun Witness1 () String (str.++ "\u{e6}" (str.++ "p" (str.++ "(" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ ")" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "4" "")))))))))))))))
;witness2: "\u0080\u00D9Z\u00F4g(9105)8029\x15"
(define-fun Witness2 () String (str.++ "\u{80}" (str.++ "\u{d9}" (str.++ "Z" (str.++ "\u{f4}" (str.++ "g" (str.++ "(" (str.++ "9" (str.++ "1" (str.++ "0" (str.++ "5" (str.++ ")" (str.++ "8" (str.++ "0" (str.++ "2" (str.++ "9" (str.++ "\u{15}" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 4) (re.range "0" "9")) (re.range ")" ")"))) (re.++ ((_ re.loop 3 4) (re.range "0" "9")) (re.range "-" "-")))(re.++ ((_ re.loop 4 9) (re.range "0" "9")) (re.union (re.++ (re.range "-" "-") ((_ re.loop 1 5) (re.range "0" "9"))) (str.to_re "")))) ((_ re.loop 4 12) (re.range "0" "9")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
