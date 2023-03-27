;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\+){1}[1-9]{1}[0-9]{0,1}[0-9]{0,1}(\s){1}[\(]{1}[1-9]{1}[0-9]{1,5}[\)]{1}[\s]{1})[1-9]{1}[0-9]{4,9}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+89\u0085(83) 89839"
(define-fun Witness1 () String (str.++ "+" (str.++ "8" (str.++ "9" (str.++ "\u{85}" (str.++ "(" (str.++ "8" (str.++ "3" (str.++ ")" (str.++ " " (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "3" (str.++ "9" "")))))))))))))))
;witness2: "+39\u0085(21)\u008598890"
(define-fun Witness2 () String (str.++ "+" (str.++ "3" (str.++ "9" (str.++ "\u{85}" (str.++ "(" (str.++ "2" (str.++ "1" (str.++ ")" (str.++ "\u{85}" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "0" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.range "+" "+")(re.++ (re.range "1" "9")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.range "(" "(")(re.++ (re.range "1" "9")(re.++ ((_ re.loop 1 5) (re.range "0" "9"))(re.++ (re.range ")" ")") (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))))))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 4 9) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
