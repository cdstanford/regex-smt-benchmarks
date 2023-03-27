;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\d]{5}[-\s]{1}[\d]{2}[-\s]{1}[\d]{2}[-\s]{1}[\d]{2}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "60437\u008500-83 80"
(define-fun Witness1 () String (str.++ "6" (str.++ "0" (str.++ "4" (str.++ "3" (str.++ "7" (str.++ "\u{85}" (str.++ "0" (str.++ "0" (str.++ "-" (str.++ "8" (str.++ "3" (str.++ " " (str.++ "8" (str.++ "0" "")))))))))))))))
;witness2: "08984\xA78\xD98\xD99"
(define-fun Witness2 () String (str.++ "0" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "4" (str.++ "\u{0a}" (str.++ "7" (str.++ "8" (str.++ "\u{0d}" (str.++ "9" (str.++ "8" (str.++ "\u{0d}" (str.++ "9" (str.++ "9" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
