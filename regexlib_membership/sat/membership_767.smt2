;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-z|A-Z]{1}[0-9]{3})[-]([0-9]{3})[-]([0-9]{2})[-]([0-9]{3})[-]([0-9]{1})
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "L897-171-99-289-9\u00BF\xB\u00C2"
(define-fun Witness1 () String (str.++ "L" (str.++ "8" (str.++ "9" (str.++ "7" (str.++ "-" (str.++ "1" (str.++ "7" (str.++ "1" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "-" (str.++ "9" (str.++ "\u{bf}" (str.++ "\u{0b}" (str.++ "\u{c2}" "")))))))))))))))))))))
;witness2: "J914-844-26-284-9"
(define-fun Witness2 () String (str.++ "J" (str.++ "9" (str.++ "1" (str.++ "4" (str.++ "-" (str.++ "8" (str.++ "4" (str.++ "4" (str.++ "-" (str.++ "2" (str.++ "6" (str.++ "-" (str.++ "2" (str.++ "8" (str.++ "4" (str.++ "-" (str.++ "9" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "A" "Z")(re.union (re.range "a" "z") (re.range "|" "|"))) ((_ re.loop 3 3) (re.range "0" "9")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
