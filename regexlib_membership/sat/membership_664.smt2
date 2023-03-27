;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\d){3})(-)?(\d){2}(-)?(\d){4}(A|B[1-7]?|M|T|C[1-4]|D)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "274-489589D"
(define-fun Witness1 () String (str.++ "2" (str.++ "7" (str.++ "4" (str.++ "-" (str.++ "4" (str.++ "8" (str.++ "9" (str.++ "5" (str.++ "8" (str.++ "9" (str.++ "D" ""))))))))))))
;witness2: "699-998399A"
(define-fun Witness2 () String (str.++ "6" (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "3" (str.++ "9" (str.++ "9" (str.++ "A" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.union (re.range "A" "A")(re.union (re.++ (re.range "B" "B") (re.opt (re.range "1" "7")))(re.union (re.union (re.range "M" "M") (re.range "T" "T"))(re.union (re.++ (re.range "C" "C") (re.range "1" "4")) (re.range "D" "D"))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
