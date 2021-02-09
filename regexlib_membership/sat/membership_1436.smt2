;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\(\d{3,4}\)|\d{3,4}-)\d{4,9}(-\d{1,5}|\d{0}))|(\d{4,12})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00E6p(198)8988994"
(define-fun Witness1 () String (seq.++ "\xe6" (seq.++ "p" (seq.++ "(" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ ")" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "4" "")))))))))))))))
;witness2: "\u0080\u00D9Z\u00F4g(9105)8029\x15"
(define-fun Witness2 () String (seq.++ "\x80" (seq.++ "\xd9" (seq.++ "Z" (seq.++ "\xf4" (seq.++ "g" (seq.++ "(" (seq.++ "9" (seq.++ "1" (seq.++ "0" (seq.++ "5" (seq.++ ")" (seq.++ "8" (seq.++ "0" (seq.++ "2" (seq.++ "9" (seq.++ "\x15" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 4) (re.range "0" "9")) (re.range ")" ")"))) (re.++ ((_ re.loop 3 4) (re.range "0" "9")) (re.range "-" "-")))(re.++ ((_ re.loop 4 9) (re.range "0" "9")) (re.union (re.++ (re.range "-" "-") ((_ re.loop 1 5) (re.range "0" "9"))) (str.to_re "")))) ((_ re.loop 4 12) (re.range "0" "9")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
