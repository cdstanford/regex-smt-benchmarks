;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(1(0|7|9)2?)\.([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "17.98.82.211"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "7" (seq.++ "." (seq.++ "9" (seq.++ "8" (seq.++ "." (seq.++ "8" (seq.++ "2" (seq.++ "." (seq.++ "2" (seq.++ "1" (seq.++ "1" "")))))))))))))
;witness2: "102.18.222.1"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "0" (seq.++ "2" (seq.++ "." (seq.++ "1" (seq.++ "8" (seq.++ "." (seq.++ "2" (seq.++ "2" (seq.++ "2" (seq.++ "." (seq.++ "1" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.range "1" "1")(re.++ (re.union (re.range "0" "0")(re.union (re.range "7" "7") (re.range "9" "9"))) (re.opt (re.range "2" "2"))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.opt (re.range "0" "1"))(re.++ (re.opt (re.range "0" "9")) (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.opt (re.range "0" "1"))(re.++ (re.opt (re.range "0" "9")) (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.opt (re.range "0" "1"))(re.++ (re.opt (re.range "0" "9")) (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5")))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
