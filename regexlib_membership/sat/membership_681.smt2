;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\d{2,4})/)?((\d{6,8})|(\d{2})-(\d{2})-(\d{2,4})|(\d{3,4})-(\d{3,4}))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "88-98-99"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "8" (seq.++ "-" (seq.++ "9" (seq.++ "8" (seq.++ "-" (seq.++ "9" (seq.++ "9" "")))))))))
;witness2: "98/896289"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "8" (seq.++ "/" (seq.++ "8" (seq.++ "9" (seq.++ "6" (seq.++ "2" (seq.++ "8" (seq.++ "9" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ ((_ re.loop 2 4) (re.range "0" "9")) (re.range "/" "/")))(re.++ (re.union ((_ re.loop 6 8) (re.range "0" "9"))(re.union (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 4) (re.range "0" "9")))))) (re.++ ((_ re.loop 3 4) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 3 4) (re.range "0" "9")))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
