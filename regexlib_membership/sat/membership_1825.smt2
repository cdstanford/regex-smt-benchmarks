;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\d{5}-\d{4})|(\d{5})|([A-Z]\d[A-Z]\s\d[A-Z]\d))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "A6X\xD3L2"
(define-fun Witness1 () String (str.++ "A" (str.++ "6" (str.++ "X" (str.++ "\u{0d}" (str.++ "3" (str.++ "L" (str.++ "2" ""))))))))
;witness2: "94749"
(define-fun Witness2 () String (str.++ "9" (str.++ "4" (str.++ "7" (str.++ "4" (str.++ "9" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9"))))(re.union ((_ re.loop 5 5) (re.range "0" "9")) (re.++ (re.range "A" "Z")(re.++ (re.range "0" "9")(re.++ (re.range "A" "Z")(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.range "0" "9")(re.++ (re.range "A" "Z") (re.range "0" "9"))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
