;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(1\s*[-\/\.]?)?(\((\d{3})\)|(\d{3}))\s*[-\/\.]?\s*(\d{3})\s*[-\/\.]?\s*(\d{4})\s*(([xX]|[eE][xX][tT])\.?\s*(\d+))*$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(898)- 997 9649"
(define-fun Witness1 () String (str.++ "(" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ ")" (str.++ "-" (str.++ " " (str.++ "9" (str.++ "9" (str.++ "7" (str.++ " " (str.++ "9" (str.++ "6" (str.++ "4" (str.++ "9" ""))))))))))))))))
;witness2: "1-(941)\xC 828\xC.\u0085 9852"
(define-fun Witness2 () String (str.++ "1" (str.++ "-" (str.++ "(" (str.++ "9" (str.++ "4" (str.++ "1" (str.++ ")" (str.++ "\u{0c}" (str.++ " " (str.++ "8" (str.++ "2" (str.++ "8" (str.++ "\u{0c}" (str.++ "." (str.++ "\u{85}" (str.++ " " (str.++ "9" (str.++ "8" (str.++ "5" (str.++ "2" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.range "1" "1")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.opt (re.range "-" "/")))))(re.++ (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range ")" ")"))) ((_ re.loop 3 3) (re.range "0" "9")))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "/"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "/"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.* (re.++ (re.union (re.union (re.range "X" "X") (re.range "x" "x")) (re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.union (re.range "X" "X") (re.range "x" "x")) (re.union (re.range "T" "T") (re.range "t" "t")))))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.+ (re.range "0" "9")))))) (str.to_re ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
