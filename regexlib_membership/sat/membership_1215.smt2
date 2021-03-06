;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(1|2|3)((\d{2}((0[13578]|1[02])(0[1-9]|[12]\d|3[01])|(0[13456789]|1[012])(0[1-9]|[12]\d|30)|02(0[1-9]|1\d|2[0-8])))|([02468][048]|[13579][26])0229)(\d{5})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "112022983396"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "1" (seq.++ "2" (seq.++ "0" (seq.++ "2" (seq.++ "2" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "3" (seq.++ "9" (seq.++ "6" "")))))))))))))
;witness2: "344022966488"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "4" (seq.++ "4" (seq.++ "0" (seq.++ "2" (seq.++ "2" (seq.++ "9" (seq.++ "6" (seq.++ "6" (seq.++ "4" (seq.++ "8" (seq.++ "8" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "1" "3")(re.++ (re.union (re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2")))) (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1") (re.range "3" "9"))) (re.++ (re.range "1" "1") (re.range "0" "2"))) (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (str.to_re (seq.++ "3" (seq.++ "0" "")))))) (re.++ (str.to_re (seq.++ "0" (seq.++ "2" ""))) (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8")))))))) (re.++ (re.union (re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8"))))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6")))) (str.to_re (seq.++ "0" (seq.++ "2" (seq.++ "2" (seq.++ "9" "")))))))(re.++ ((_ re.loop 5 5) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
