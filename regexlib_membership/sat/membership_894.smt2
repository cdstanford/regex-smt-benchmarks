;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\s+|)((\(\d{3}\) +)|(\d{3}-)|(\d{3} +))?\d{3}(-| +)\d{4}( +x\d{1,4})?(\s+|)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(868) 879 8981"
(define-fun Witness1 () String (str.++ "(" (str.++ "8" (str.++ "6" (str.++ "8" (str.++ ")" (str.++ " " (str.++ "8" (str.++ "7" (str.++ "9" (str.++ " " (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "1" "")))))))))))))))
;witness2: "\u00CE531-998-8960 \u00FA"
(define-fun Witness2 () String (str.++ "\u{ce}" (str.++ "5" (str.++ "3" (str.++ "1" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "-" (str.++ "8" (str.++ "9" (str.++ "6" (str.++ "0" (str.++ " " (str.++ "\u{fa}" ""))))))))))))))))

(assert (= regexA (re.++ (re.union (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re ""))(re.++ (re.opt (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range ")" ")") (re.+ (re.range " " " ")))))(re.union (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range "-" "-")) (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.+ (re.range " " " "))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "-" "-") (re.+ (re.range " " " ")))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.+ (re.range " " " "))(re.++ (re.range "x" "x") ((_ re.loop 1 4) (re.range "0" "9"))))) (re.union (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
