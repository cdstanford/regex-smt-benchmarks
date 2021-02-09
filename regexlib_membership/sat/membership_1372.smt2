;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\(]? ([^0-1]){1}([0-9]){2}([-,\),/,\.])*([ ])?([^0-1]){1}([0-9]){2}[ ]?[-]?[/]?[\.]? ([0-9]){4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "( F28.,))_98-. 4869"
(define-fun Witness1 () String (seq.++ "(" (seq.++ " " (seq.++ "F" (seq.++ "2" (seq.++ "8" (seq.++ "." (seq.++ "," (seq.++ ")" (seq.++ ")" (seq.++ "_" (seq.++ "9" (seq.++ "8" (seq.++ "-" (seq.++ "." (seq.++ " " (seq.++ "4" (seq.++ "8" (seq.++ "6" (seq.++ "9" ""))))))))))))))))))))
;witness2: "( \x050),.))) *01 - 8616"
(define-fun Witness2 () String (seq.++ "(" (seq.++ " " (seq.++ "\x00" (seq.++ "5" (seq.++ "0" (seq.++ ")" (seq.++ "," (seq.++ "." (seq.++ ")" (seq.++ ")" (seq.++ ")" (seq.++ " " (seq.++ "*" (seq.++ "0" (seq.++ "1" (seq.++ " " (seq.++ "-" (seq.++ " " (seq.++ "8" (seq.++ "6" (seq.++ "1" (seq.++ "6" "")))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "(" "("))(re.++ (re.range " " " ")(re.++ (re.union (re.range "\x00" "/") (re.range "2" "\xff"))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.* (re.union (re.range ")" ")") (re.range "," "/")))(re.++ (re.opt (re.range " " " "))(re.++ (re.union (re.range "\x00" "/") (re.range "2" "\xff"))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.opt (re.range "." "."))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
