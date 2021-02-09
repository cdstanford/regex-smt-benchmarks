;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z]{1}( |-)?[1-9]{1}[0-9]{3}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Y-1802"
(define-fun Witness1 () String (seq.++ "Y" (seq.++ "-" (seq.++ "1" (seq.++ "8" (seq.++ "0" (seq.++ "2" "")))))))
;witness2: "P4798"
(define-fun Witness2 () String (seq.++ "P" (seq.++ "4" (seq.++ "7" (seq.++ "9" (seq.++ "8" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "A" "Z")(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
