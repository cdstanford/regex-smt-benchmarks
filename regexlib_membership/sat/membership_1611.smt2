;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\d{3}.?\d{3}.?\d{3}-?\d{2})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "859\u00B9973079-35"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "5" (seq.++ "9" (seq.++ "\xb9" (seq.++ "9" (seq.++ "7" (seq.++ "3" (seq.++ "0" (seq.++ "7" (seq.++ "9" (seq.++ "-" (seq.++ "3" (seq.++ "5" ""))))))))))))))
;witness2: "84899884816"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "4" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "8" (seq.++ "1" (seq.++ "6" ""))))))))))))

(assert (= regexA (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 2 2) (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
