;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\\(]{0,1}([0-9]){3}[\\)]{0,1}[ ]?([^0-1]){1}([0-9]){2}[ ]?[-]?[ ]?([0-9]){4}[ ]*((x){0,1}([0-9]){1,5}){0,1}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "988\\u008A59-5999 5"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "\x5c" (seq.++ "\x8a" (seq.++ "5" (seq.++ "9" (seq.++ "-" (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ " " (seq.++ "5" "")))))))))))))))
;witness2: "984\ `82  5398"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "\x5c" (seq.++ " " (seq.++ "`" (seq.++ "8" (seq.++ "2" (seq.++ " " (seq.++ " " (seq.++ "5" (seq.++ "3" (seq.++ "9" (seq.++ "8" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "(" "(") (re.range "\x5c" "\x5c")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range ")" ")") (re.range "\x5c" "\x5c")))(re.++ (re.opt (re.range " " " "))(re.++ (re.union (re.range "\x00" "/") (re.range "2" "\xff"))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.* (re.range " " " "))(re.++ (re.opt (re.++ (re.opt (re.range "x" "x")) ((_ re.loop 1 5) (re.range "0" "9")))) (str.to_re ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
