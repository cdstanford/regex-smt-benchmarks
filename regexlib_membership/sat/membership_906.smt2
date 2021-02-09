;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{4})[.](0{0,1}[1-9]|1[012])[.](0{0,1}[1-9]|[12][0-9]|3[01])[.](\d{2})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "6899.12.5.01"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "." (seq.++ "1" (seq.++ "2" (seq.++ "." (seq.++ "5" (seq.++ "." (seq.++ "0" (seq.++ "1" "")))))))))))))
;witness2: "9959.08.29.06"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "9" (seq.++ "5" (seq.++ "9" (seq.++ "." (seq.++ "0" (seq.++ "8" (seq.++ "." (seq.++ "2" (seq.++ "9" (seq.++ "." (seq.++ "0" (seq.++ "6" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
