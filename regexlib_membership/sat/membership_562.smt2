;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{4}(?:(?:(?:\-)?(?:00[1-9]|0[1-9][0-9]|[1-2][0-9][0-9]|3[0-5][0-9]|36[0-6]))?|(?:(?:\-)?(?:1[0-2]|0[1-9]))?|(?:(?:\-)?(?:1[0-2]|0[1-9])(?:\-)?(?:0[1-9]|[12][0-9]|3[01]))?|(?:(?:\-)?W(?:0[1-9]|[1-4][0-9]5[0-3]))?|(?:(?:\-)?W(?:0[1-9]|[1-4][0-9]5[0-3])(?:\-)?[1-7])?)?)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "4458"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "4" (seq.++ "5" (seq.++ "8" "")))))
;witness2: "1886"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "8" (seq.++ "8" (seq.++ "6" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.opt (re.union (re.opt (re.++ (re.opt (re.range "-" "-")) (re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "0" ""))) (re.range "1" "9"))(re.union (re.++ (re.range "0" "0")(re.++ (re.range "1" "9") (re.range "0" "9")))(re.union (re.++ (re.range "1" "2")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "3" "3")(re.++ (re.range "0" "5") (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "3" (seq.++ "6" ""))) (re.range "0" "6"))))))))(re.union (re.opt (re.++ (re.opt (re.range "-" "-")) (re.union (re.++ (re.range "1" "1") (re.range "0" "2")) (re.++ (re.range "0" "0") (re.range "1" "9")))))(re.union (re.opt (re.++ (re.opt (re.range "-" "-"))(re.++ (re.union (re.++ (re.range "1" "1") (re.range "0" "2")) (re.++ (re.range "0" "0") (re.range "1" "9")))(re.++ (re.opt (re.range "-" "-")) (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))))))(re.union (re.opt (re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "W" "W") (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "4")(re.++ (re.range "0" "9")(re.++ (re.range "5" "5") (re.range "0" "3")))))))) (re.opt (re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "W" "W")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "4")(re.++ (re.range "0" "9")(re.++ (re.range "5" "5") (re.range "0" "3")))))(re.++ (re.opt (re.range "-" "-")) (re.range "1" "7")))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
