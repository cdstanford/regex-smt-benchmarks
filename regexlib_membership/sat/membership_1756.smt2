;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\{?[a-fA-F\d]{8}-([a-fA-F\d]{4}-){3}[a-fA-F\d]{12}\}?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "{F8EE4BF5-A96f-25cD-fda0-8A9e5AdA8b7e}"
(define-fun Witness1 () String (str.++ "{" (str.++ "F" (str.++ "8" (str.++ "E" (str.++ "E" (str.++ "4" (str.++ "B" (str.++ "F" (str.++ "5" (str.++ "-" (str.++ "A" (str.++ "9" (str.++ "6" (str.++ "f" (str.++ "-" (str.++ "2" (str.++ "5" (str.++ "c" (str.++ "D" (str.++ "-" (str.++ "f" (str.++ "d" (str.++ "a" (str.++ "0" (str.++ "-" (str.++ "8" (str.++ "A" (str.++ "9" (str.++ "e" (str.++ "5" (str.++ "A" (str.++ "d" (str.++ "A" (str.++ "8" (str.++ "b" (str.++ "7" (str.++ "e" (str.++ "}" "")))))))))))))))))))))))))))))))))))))))
;witness2: "4C23dA8E-98Eb-96B7-DeA8-3F98f98899e4"
(define-fun Witness2 () String (str.++ "4" (str.++ "C" (str.++ "2" (str.++ "3" (str.++ "d" (str.++ "A" (str.++ "8" (str.++ "E" (str.++ "-" (str.++ "9" (str.++ "8" (str.++ "E" (str.++ "b" (str.++ "-" (str.++ "9" (str.++ "6" (str.++ "B" (str.++ "7" (str.++ "-" (str.++ "D" (str.++ "e" (str.++ "A" (str.++ "8" (str.++ "-" (str.++ "3" (str.++ "F" (str.++ "9" (str.++ "8" (str.++ "f" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "e" (str.++ "4" "")))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "{" "{"))(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range "-" "-")))(re.++ ((_ re.loop 12 12) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.range "}" "}")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
