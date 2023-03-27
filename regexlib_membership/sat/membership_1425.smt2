;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\(\d{3}\) ?)|(\d{3}[- \.]))?\d{3}[- \.]\d{4}(\s(x\d+)?){0,1}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "W\u00A2:\u00D2\u00DD\u00D8\u0089999-901 9885"
(define-fun Witness1 () String (str.++ "W" (str.++ "\u{a2}" (str.++ ":" (str.++ "\u{d2}" (str.++ "\u{dd}" (str.++ "\u{d8}" (str.++ "\u{89}" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "9" (str.++ "0" (str.++ "1" (str.++ " " (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "5" ""))))))))))))))))))))
;witness2: "r\u00AB\x16527 586 3122 x8"
(define-fun Witness2 () String (str.++ "r" (str.++ "\u{ab}" (str.++ "\u{16}" (str.++ "5" (str.++ "2" (str.++ "7" (str.++ " " (str.++ "5" (str.++ "8" (str.++ "6" (str.++ " " (str.++ "3" (str.++ "1" (str.++ "2" (str.++ "2" (str.++ " " (str.++ "x" (str.++ "8" "")))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range ")" ")") (re.opt (re.range " " " "))))) (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.union (re.range " " " ") (re.range "-" ".")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range " " " ") (re.range "-" "."))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) (re.opt (re.++ (re.range "x" "x") (re.+ (re.range "0" "9")))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
