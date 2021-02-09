;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{4}[\-\/\s]?((((0[13578])|(1[02]))[\-\/\s]?(([0-2][0-9])|(3[01])))|(((0[469])|(11))[\-\/\s]?(([0-2][0-9])|(30)))|(02[\-\/\s]?[0-2][0-9]))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "399603\u00A023"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "9" (seq.++ "9" (seq.++ "6" (seq.++ "0" (seq.++ "3" (seq.++ "\xa0" (seq.++ "2" (seq.++ "3" ""))))))))))
;witness2: "498811\u008530"
(define-fun Witness2 () String (seq.++ "4" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "1" (seq.++ "1" (seq.++ "\x85" (seq.++ "3" (seq.++ "0" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "/" "/")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))(re.++ (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "/" "/")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))) (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9")))) (str.to_re (seq.++ "1" (seq.++ "1" ""))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "/" "/")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))) (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (str.to_re (seq.++ "3" (seq.++ "0" "")))))) (re.++ (str.to_re (seq.++ "0" (seq.++ "2" "")))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "/" "/")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))(re.++ (re.range "0" "2") (re.range "0" "9")))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
