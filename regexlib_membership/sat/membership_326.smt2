;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(-?[1-9](\.\d+)?)((\s?[X*]\s?10[E^]([+-]?\d+))|(E([+-]?\d+)))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-9\u0085X10^+879"
(define-fun Witness1 () String (str.++ "-" (str.++ "9" (str.++ "\u{85}" (str.++ "X" (str.++ "1" (str.++ "0" (str.++ "^" (str.++ "+" (str.++ "8" (str.++ "7" (str.++ "9" ""))))))))))))
;witness2: "6E-95"
(define-fun Witness2 () String (str.++ "6" (str.++ "E" (str.++ "-" (str.++ "9" (str.++ "5" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "1" "9") (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9"))))))(re.++ (re.union (re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.range "*" "*") (re.range "X" "X"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (str.to_re (str.++ "1" (str.++ "0" "")))(re.++ (re.union (re.range "E" "E") (re.range "^" "^")) (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))) (re.+ (re.range "0" "9")))))))) (re.++ (re.range "E" "E") (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))) (re.+ (re.range "0" "9"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
