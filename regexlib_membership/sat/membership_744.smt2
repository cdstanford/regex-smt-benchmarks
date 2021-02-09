;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{5})$|^([a-zA-Z]\d[a-zA-Z]( )?\d[a-zA-Z]\d)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "88888"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "8" ""))))))
;witness2: "j6Y9M9"
(define-fun Witness2 () String (seq.++ "j" (seq.++ "6" (seq.++ "Y" (seq.++ "9" (seq.++ "M" (seq.++ "9" "")))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.range "0" "9")) (str.to_re ""))) (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.opt (re.range " " " "))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range "0" "9"))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
