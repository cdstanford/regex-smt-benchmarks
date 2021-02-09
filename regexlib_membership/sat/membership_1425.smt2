;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\(\d{3}\) ?)|(\d{3}[- \.]))?\d{3}[- \.]\d{4}(\s(x\d+)?){0,1}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "W\u00A2:\u00D2\u00DD\u00D8\u0089999-901 9885"
(define-fun Witness1 () String (seq.++ "W" (seq.++ "\xa2" (seq.++ ":" (seq.++ "\xd2" (seq.++ "\xdd" (seq.++ "\xd8" (seq.++ "\x89" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "-" (seq.++ "9" (seq.++ "0" (seq.++ "1" (seq.++ " " (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "5" ""))))))))))))))))))))
;witness2: "r\u00AB\x16527 586 3122 x8"
(define-fun Witness2 () String (seq.++ "r" (seq.++ "\xab" (seq.++ "\x16" (seq.++ "5" (seq.++ "2" (seq.++ "7" (seq.++ " " (seq.++ "5" (seq.++ "8" (seq.++ "6" (seq.++ " " (seq.++ "3" (seq.++ "1" (seq.++ "2" (seq.++ "2" (seq.++ " " (seq.++ "x" (seq.++ "8" "")))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range ")" ")") (re.opt (re.range " " " "))))) (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.union (re.range " " " ") (re.range "-" ".")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range " " " ") (re.range "-" "."))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) (re.opt (re.++ (re.range "x" "x") (re.+ (re.range "0" "9")))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
