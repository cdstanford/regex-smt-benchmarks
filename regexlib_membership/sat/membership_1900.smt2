;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(295)798-6038"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "2" (seq.++ "9" (seq.++ "5" (seq.++ ")" (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ "-" (seq.++ "6" (seq.++ "0" (seq.++ "3" (seq.++ "8" ""))))))))))))))
;witness2: "986-952-0098\u0090"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "8" (seq.++ "6" (seq.++ "-" (seq.++ "9" (seq.++ "5" (seq.++ "2" (seq.++ "-" (seq.++ "0" (seq.++ "0" (seq.++ "9" (seq.++ "8" (seq.++ "\x90" ""))))))))))))))

(assert (= regexA (re.++ (re.opt (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range ")" ")") (re.opt (re.range " " " "))))) (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range "-" "-"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
