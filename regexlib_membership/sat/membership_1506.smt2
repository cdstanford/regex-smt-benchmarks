;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((([0][1-9]|[12][\d])|[3][01])[-/]([0][13578]|[1][02])[-/][1-9]\d\d\d)|((([0][1-9]|[12][\d])|[3][0])[-/]([0][13456789]|[1][012])[-/][1-9]\d\d\d)|(([0][1-9]|[12][\d])[-/][0][2][-/][1-9]\d([02468][048]|[13579][26]))|(([0][1-9]|[12][0-8])[-/][0][2][-/][1-9]\d\d\d)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "12-02-8480"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "2" (seq.++ "-" (seq.++ "0" (seq.++ "2" (seq.++ "-" (seq.++ "8" (seq.++ "4" (seq.++ "8" (seq.++ "0" "")))))))))))
;witness2: "08-02-5076"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "8" (seq.++ "-" (seq.++ "0" (seq.++ "2" (seq.++ "-" (seq.++ "5" (seq.++ "0" (seq.++ "7" (seq.++ "6" "")))))))))))

(assert (= regexA (re.union (re.++ (re.union (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "2") (re.range "0" "9"))) (re.++ (re.range "3" "3") (re.range "0" "1")))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9"))))))))(re.union (re.++ (re.union (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "2") (re.range "0" "9"))) (str.to_re (seq.++ "3" (seq.++ "0" ""))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1") (re.range "3" "9"))) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9"))))))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "2") (re.range "0" "9")))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (str.to_re (seq.++ "0" (seq.++ "2" "")))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.range "1" "9")(re.++ (re.range "0" "9") (re.union (re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8"))))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6")))))))))) (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "2") (re.range "0" "8")))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (str.to_re (seq.++ "0" (seq.++ "2" "")))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
