;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [\+]{0,1}(\d{10,13}|[\(][\+]{0,1}\d{2,}[\13)]*\d{5,13}|\d{2,6}[\-]{1}\d{2,13}[\-]*\d{3,13})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ".D+8299158488"
(define-fun Witness1 () String (str.++ "." (str.++ "D" (str.++ "+" (str.++ "8" (str.++ "2" (str.++ "9" (str.++ "9" (str.++ "1" (str.++ "5" (str.++ "8" (str.++ "4" (str.++ "8" (str.++ "8" ""))))))))))))))
;witness2: "\u00918818323908978"
(define-fun Witness2 () String (str.++ "\u{91}" (str.++ "8" (str.++ "8" (str.++ "1" (str.++ "8" (str.++ "3" (str.++ "2" (str.++ "3" (str.++ "9" (str.++ "0" (str.++ "8" (str.++ "9" (str.++ "7" (str.++ "8" "")))))))))))))))

(assert (= regexA (re.++ (re.opt (re.range "+" "+")) (re.union ((_ re.loop 10 13) (re.range "0" "9"))(re.union (re.++ (re.range "(" "(")(re.++ (re.opt (re.range "+" "+"))(re.++ (re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.* (re.range "0" "9")))(re.++ (re.* (re.union (re.range "\u{0b}" "\u{0b}") (re.range ")" ")"))) ((_ re.loop 5 13) (re.range "0" "9")))))) (re.++ ((_ re.loop 2 6) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 13) (re.range "0" "9"))(re.++ (re.* (re.range "-" "-")) ((_ re.loop 3 13) (re.range "0" "9")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
