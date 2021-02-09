;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((((0?[1-9]|[12]\d|3[01])[-/]([0]?[13578]|1[02]))|((0?[1-9]|[12]\d|30)[-/]([0]?[469]|11))|(([01]?\d|2[0-8])[-/]0?2))[-/]((20|19)?\d{2}|\d{1,2}))|(29[-/]0?2[-/]((19)|(20))?([13579][26]|[24680][048])))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "09-9/2092"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "9" (seq.++ "-" (seq.++ "9" (seq.++ "/" (seq.++ "2" (seq.++ "0" (seq.++ "9" (seq.++ "2" ""))))))))))
;witness2: "05/02/9"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "5" (seq.++ "/" (seq.++ "0" (seq.++ "2" (seq.++ "/" (seq.++ "9" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/")) (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))))(re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (str.to_re (seq.++ "3" (seq.++ "0" "")))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/")) (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9")))) (str.to_re (seq.++ "1" (seq.++ "1" "")))))) (re.++ (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8")))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.opt (re.range "0" "0")) (re.range "2" "2"))))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/")) (re.union (re.++ (re.opt (re.union (str.to_re (seq.++ "2" (seq.++ "0" ""))) (str.to_re (seq.++ "1" (seq.++ "9" ""))))) ((_ re.loop 2 2) (re.range "0" "9"))) ((_ re.loop 1 2) (re.range "0" "9"))))) (re.++ (str.to_re (seq.++ "2" (seq.++ "9" "")))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.opt (re.range "0" "0"))(re.++ (re.range "2" "2")(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.opt (re.union (str.to_re (seq.++ "1" (seq.++ "9" ""))) (str.to_re (seq.++ "2" (seq.++ "0" ""))))) (re.union (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))) (re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8"))))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
