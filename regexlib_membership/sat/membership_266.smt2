;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*(?<Last>[-A-Za-z ]+)[.](?<First>[-A-Za-z ]+)(?:[.](?<Middle>[-A-Za-z ]+))?(?:[.](?<Ordinal>[IVX]+))?(?:[.](?<Number>\d{10}))\s*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00A0\u00A0 \u0085\u0085\u0085  \x9\u0085\u00A0h -.-.-.8099789889\u00A0 "
(define-fun Witness1 () String (str.++ "\u{a0}" (str.++ "\u{a0}" (str.++ " " (str.++ "\u{85}" (str.++ "\u{85}" (str.++ "\u{85}" (str.++ " " (str.++ " " (str.++ "\u{09}" (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ "h" (str.++ " " (str.++ "-" (str.++ "." (str.++ "-" (str.++ "." (str.++ "-" (str.++ "." (str.++ "8" (str.++ "0" (str.++ "9" (str.++ "9" (str.++ "7" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "\u{a0}" (str.++ " " ""))))))))))))))))))))))))))))))))
;witness2: " ny N.-L.Ak.4708625778\u00A0 \u00A0 "
(define-fun Witness2 () String (str.++ " " (str.++ "n" (str.++ "y" (str.++ " " (str.++ "N" (str.++ "." (str.++ "-" (str.++ "L" (str.++ "." (str.++ "A" (str.++ "k" (str.++ "." (str.++ "4" (str.++ "7" (str.++ "0" (str.++ "8" (str.++ "6" (str.++ "2" (str.++ "5" (str.++ "7" (str.++ "7" (str.++ "8" (str.++ "\u{a0}" (str.++ " " (str.++ "\u{a0}" (str.++ " " "")))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.opt (re.++ (re.range "." ".") (re.+ (re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "A" "Z") (re.range "a" "z")))))))(re.++ (re.opt (re.++ (re.range "." ".") (re.+ (re.union (re.range "I" "I")(re.union (re.range "V" "V") (re.range "X" "X"))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 10 10) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
