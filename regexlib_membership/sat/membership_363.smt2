;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\+91(-)?|91(-)?|0(-)?)?(9)[0-9]{9}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0-9988997085"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "-" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "7" (seq.++ "0" (seq.++ "8" (seq.++ "5" "")))))))))))))
;witness2: "\x10-+91-9952287199\u00D4\u00CA\u00C1\u00D7"
(define-fun Witness2 () String (seq.++ "\x10" (seq.++ "-" (seq.++ "+" (seq.++ "9" (seq.++ "1" (seq.++ "-" (seq.++ "9" (seq.++ "9" (seq.++ "5" (seq.++ "2" (seq.++ "2" (seq.++ "8" (seq.++ "7" (seq.++ "1" (seq.++ "9" (seq.++ "9" (seq.++ "\xd4" (seq.++ "\xca" (seq.++ "\xc1" (seq.++ "\xd7" "")))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.union (re.++ (str.to_re (seq.++ "+" (seq.++ "9" (seq.++ "1" "")))) (re.opt (re.range "-" "-")))(re.union (re.++ (str.to_re (seq.++ "9" (seq.++ "1" ""))) (re.opt (re.range "-" "-"))) (re.++ (re.range "0" "0") (re.opt (re.range "-" "-"))))))(re.++ (re.range "9" "9") ((_ re.loop 9 9) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
