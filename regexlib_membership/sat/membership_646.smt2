;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(\d{2}\x2E\d{3}\x2E\d{3}[-]\d{1})$|^(\d{2}\x2E\d{3}\x2E\d{3})$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "48.928.291-9"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "8" (seq.++ "." (seq.++ "9" (seq.++ "2" (seq.++ "8" (seq.++ "." (seq.++ "2" (seq.++ "9" (seq.++ "1" (seq.++ "-" (seq.++ "9" "")))))))))))))
;witness2: "69.382.878"
(define-fun Witness2 () String (seq.++ "6" (seq.++ "9" (seq.++ "." (seq.++ "3" (seq.++ "8" (seq.++ "2" (seq.++ "." (seq.++ "8" (seq.++ "7" (seq.++ "8" "")))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") (re.range "0" "9"))))))) (str.to_re ""))) (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "." ".") ((_ re.loop 3 3) (re.range "0" "9")))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
