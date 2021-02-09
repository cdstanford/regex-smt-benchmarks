;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(000000[1-9])$|^(00000[1-9][0-9])$|^(0000[1-9][0-9][0-9])$|^(000[1-9][0-9][0-9][0-9])$|^(00[1-9][0-9][0-9][0-9][0-9])$|^(0[1-9][0-9][0-9][0-9][0-9][0-9])$|^([1-9][0-9][0-9][0-9][0-9][0-9][0-9])$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0489988"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "4" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "8" ""))))))))
;witness2: "0057298"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "0" (seq.++ "5" (seq.++ "7" (seq.++ "2" (seq.++ "9" (seq.++ "8" ""))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (seq.++ "0" (seq.++ "0" (seq.++ "0" (seq.++ "0" (seq.++ "0" (seq.++ "0" ""))))))) (re.range "1" "9")) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (seq.++ "0" (seq.++ "0" (seq.++ "0" (seq.++ "0" (seq.++ "0" ""))))))(re.++ (re.range "1" "9") (re.range "0" "9"))) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (seq.++ "0" (seq.++ "0" (seq.++ "0" (seq.++ "0" "")))))(re.++ (re.range "1" "9")(re.++ (re.range "0" "9") (re.range "0" "9")))) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (seq.++ "0" (seq.++ "0" (seq.++ "0" ""))))(re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9"))))) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (seq.++ "0" (seq.++ "0" "")))(re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9")))))) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.++ (re.range "0" "0")(re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9"))))))) (str.to_re ""))) (re.++ (str.to_re "")(re.++ (re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9"))))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
