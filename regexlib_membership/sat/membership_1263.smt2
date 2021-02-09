;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9954-08-01"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "9" (seq.++ "5" (seq.++ "4" (seq.++ "-" (seq.++ "0" (seq.++ "8" (seq.++ "-" (seq.++ "0" (seq.++ "1" "")))))))))))
;witness2: "9082-04-08"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "0" (seq.++ "8" (seq.++ "2" (seq.++ "-" (seq.++ "0" (seq.++ "4" (seq.++ "-" (seq.++ "0" (seq.++ "8" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.union (str.to_re (seq.++ "1" (seq.++ "0" ""))) (str.to_re (seq.++ "1" (seq.++ "2" "")))))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "2" (seq.++ "-" "")))) (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "2") (re.range "0" "9")))) (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9")))) (str.to_re (seq.++ "1" (seq.++ "1" ""))))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (str.to_re (seq.++ "3" (seq.++ "0" ""))))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
