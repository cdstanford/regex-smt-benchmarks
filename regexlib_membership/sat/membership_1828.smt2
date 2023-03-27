;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\\(]{0,1}([0-9]){3}[\\)]{0,1}[ ]?([^0-1]){1}([0-9]){2}[ ]?[-]?[ ]?([0-9]){4}[ ]*((x){0,1}([0-9]){1,5}){0,1}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "988\\u008A59-5999 5"
(define-fun Witness1 () String (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "\u{5c}" (str.++ "\u{8a}" (str.++ "5" (str.++ "9" (str.++ "-" (str.++ "5" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ " " (str.++ "5" "")))))))))))))))
;witness2: "984\ `82  5398"
(define-fun Witness2 () String (str.++ "9" (str.++ "8" (str.++ "4" (str.++ "\u{5c}" (str.++ " " (str.++ "`" (str.++ "8" (str.++ "2" (str.++ " " (str.++ " " (str.++ "5" (str.++ "3" (str.++ "9" (str.++ "8" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "(" "(") (re.range "\u{5c}" "\u{5c}")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range ")" ")") (re.range "\u{5c}" "\u{5c}")))(re.++ (re.opt (re.range " " " "))(re.++ (re.union (re.range "\u{00}" "/") (re.range "2" "\u{ff}"))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.* (re.range " " " "))(re.++ (re.opt (re.++ (re.opt (re.range "x" "x")) ((_ re.loop 1 5) (re.range "0" "9")))) (str.to_re ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
