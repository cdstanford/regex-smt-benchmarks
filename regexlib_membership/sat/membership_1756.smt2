;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\{?[a-fA-F\d]{8}-([a-fA-F\d]{4}-){3}[a-fA-F\d]{12}\}?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "{F8EE4BF5-A96f-25cD-fda0-8A9e5AdA8b7e}"
(define-fun Witness1 () String (seq.++ "{" (seq.++ "F" (seq.++ "8" (seq.++ "E" (seq.++ "E" (seq.++ "4" (seq.++ "B" (seq.++ "F" (seq.++ "5" (seq.++ "-" (seq.++ "A" (seq.++ "9" (seq.++ "6" (seq.++ "f" (seq.++ "-" (seq.++ "2" (seq.++ "5" (seq.++ "c" (seq.++ "D" (seq.++ "-" (seq.++ "f" (seq.++ "d" (seq.++ "a" (seq.++ "0" (seq.++ "-" (seq.++ "8" (seq.++ "A" (seq.++ "9" (seq.++ "e" (seq.++ "5" (seq.++ "A" (seq.++ "d" (seq.++ "A" (seq.++ "8" (seq.++ "b" (seq.++ "7" (seq.++ "e" (seq.++ "}" "")))))))))))))))))))))))))))))))))))))))
;witness2: "4C23dA8E-98Eb-96B7-DeA8-3F98f98899e4"
(define-fun Witness2 () String (seq.++ "4" (seq.++ "C" (seq.++ "2" (seq.++ "3" (seq.++ "d" (seq.++ "A" (seq.++ "8" (seq.++ "E" (seq.++ "-" (seq.++ "9" (seq.++ "8" (seq.++ "E" (seq.++ "b" (seq.++ "-" (seq.++ "9" (seq.++ "6" (seq.++ "B" (seq.++ "7" (seq.++ "-" (seq.++ "D" (seq.++ "e" (seq.++ "A" (seq.++ "8" (seq.++ "-" (seq.++ "3" (seq.++ "F" (seq.++ "9" (seq.++ "8" (seq.++ "f" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "e" (seq.++ "4" "")))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "{" "{"))(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range "-" "-")))(re.++ ((_ re.loop 12 12) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.range "}" "}")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
