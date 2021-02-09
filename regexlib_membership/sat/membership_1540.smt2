;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[S-s]( |-)?[1-9]{1}[0-9]{2}( |-)?[0-9]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "X19894"
(define-fun Witness1 () String (seq.++ "X" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "4" "")))))))
;witness2: "^99789"
(define-fun Witness2 () String (seq.++ "^" (seq.++ "9" (seq.++ "9" (seq.++ "7" (seq.++ "8" (seq.++ "9" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "S" "s")(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
