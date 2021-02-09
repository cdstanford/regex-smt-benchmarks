;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\d){3})(-)?(\d){2}(-)?(\d){4}(A|B[1-7]?|M|T|C[1-4]|D)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "274-489589D"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "7" (seq.++ "4" (seq.++ "-" (seq.++ "4" (seq.++ "8" (seq.++ "9" (seq.++ "5" (seq.++ "8" (seq.++ "9" (seq.++ "D" ""))))))))))))
;witness2: "699-998399A"
(define-fun Witness2 () String (seq.++ "6" (seq.++ "9" (seq.++ "9" (seq.++ "-" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "9" (seq.++ "9" (seq.++ "A" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.union (re.range "A" "A")(re.union (re.++ (re.range "B" "B") (re.opt (re.range "1" "7")))(re.union (re.union (re.range "M" "M") (re.range "T" "T"))(re.union (re.++ (re.range "C" "C") (re.range "1" "4")) (re.range "D" "D"))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
