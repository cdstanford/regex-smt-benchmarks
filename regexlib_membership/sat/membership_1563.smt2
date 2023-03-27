;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([\(]?(?<AreaCode>[0-9]{3})[\)]?)?[ \.\-]?(?<Exchange>[0-9]{3})[ \.\-](?<Number>[0-9]{4})
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(289349 9555\u00CF\u00AE\x1C\u00D1\x2\u00BD"
(define-fun Witness1 () String (str.++ "(" (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "3" (str.++ "4" (str.++ "9" (str.++ " " (str.++ "9" (str.++ "5" (str.++ "5" (str.++ "5" (str.++ "\u{cf}" (str.++ "\u{ae}" (str.++ "\u{1c}" (str.++ "\u{d1}" (str.++ "\u{02}" (str.++ "\u{bd}" "")))))))))))))))))))
;witness2: "813 1390\u00C8A\u00D9"
(define-fun Witness2 () String (str.++ "8" (str.++ "1" (str.++ "3" (str.++ " " (str.++ "1" (str.++ "3" (str.++ "9" (str.++ "0" (str.++ "\u{c8}" (str.++ "A" (str.++ "\u{d9}" ""))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.opt (re.range "(" "("))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range ")" ")")))))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" ".")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range " " " ") (re.range "-" ".")) ((_ re.loop 4 4) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
