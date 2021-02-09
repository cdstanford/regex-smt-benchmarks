;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([\(]?(?<AreaCode>[0-9]{3})[\)]?)?[ \.\-]?(?<Exchange>[0-9]{3})[ \.\-](?<Number>[0-9]{4})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(289349 9555\u00CF\u00AE\x1C\u00D1\x2\u00BD"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "3" (seq.++ "4" (seq.++ "9" (seq.++ " " (seq.++ "9" (seq.++ "5" (seq.++ "5" (seq.++ "5" (seq.++ "\xcf" (seq.++ "\xae" (seq.++ "\x1c" (seq.++ "\xd1" (seq.++ "\x02" (seq.++ "\xbd" "")))))))))))))))))))
;witness2: "813 1390\u00C8A\u00D9"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "1" (seq.++ "3" (seq.++ " " (seq.++ "1" (seq.++ "3" (seq.++ "9" (seq.++ "0" (seq.++ "\xc8" (seq.++ "A" (seq.++ "\xd9" ""))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.opt (re.range "(" "("))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range ")" ")")))))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" ".")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range " " " ") (re.range "-" ".")) ((_ re.loop 4 4) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
