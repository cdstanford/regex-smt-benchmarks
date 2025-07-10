;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+48\s+)?\d{3}(\s*|\-)\d{3}(\s*|\-)\d{3}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+48\xD915-295 \u0085\x9\u0085679"
(define-fun Witness1 () String (str.++ "+" (str.++ "4" (str.++ "8" (str.++ "\u{0d}" (str.++ "9" (str.++ "1" (str.++ "5" (str.++ "-" (str.++ "2" (str.++ "9" (str.++ "5" (str.++ " " (str.++ "\u{85}" (str.++ "\u{09}" (str.++ "\u{85}" (str.++ "6" (str.++ "7" (str.++ "9" "")))))))))))))))))))
;witness2: "+48\u00A0\u0085\u00A0 929904882"
(define-fun Witness2 () String (str.++ "+" (str.++ "4" (str.++ "8" (str.++ "\u{a0}" (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ " " (str.++ "9" (str.++ "2" (str.++ "9" (str.++ "9" (str.++ "0" (str.++ "4" (str.++ "8" (str.++ "8" (str.++ "2" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (str.to_re (str.++ "+" (str.++ "4" (str.++ "8" "")))) (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
