;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z][a-z]+)\s([A-Z][a-zA-Z-]+)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Lp\xBW-k"
(define-fun Witness1 () String (str.++ "L" (str.++ "p" (str.++ "\u{0b}" (str.++ "W" (str.++ "-" (str.++ "k" "")))))))
;witness2: "Mf\u0085Q-"
(define-fun Witness2 () String (str.++ "M" (str.++ "f" (str.++ "\u{85}" (str.++ "Q" (str.++ "-" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.range "A" "Z") (re.+ (re.range "a" "z")))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.++ (re.range "A" "Z") (re.+ (re.union (re.range "-" "-")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
