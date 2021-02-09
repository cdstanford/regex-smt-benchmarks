;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (1 )?\d{3} \d{3}-\d{4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "C\u008D\u00F01 699 980-7538"
(define-fun Witness1 () String (seq.++ "C" (seq.++ "\x8d" (seq.++ "\xf0" (seq.++ "1" (seq.++ " " (seq.++ "6" (seq.++ "9" (seq.++ "9" (seq.++ " " (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "-" (seq.++ "7" (seq.++ "5" (seq.++ "3" (seq.++ "8" ""))))))))))))))))))
;witness2: "1 903 943-8489|"
(define-fun Witness2 () String (seq.++ "1" (seq.++ " " (seq.++ "9" (seq.++ "0" (seq.++ "3" (seq.++ " " (seq.++ "9" (seq.++ "4" (seq.++ "3" (seq.++ "-" (seq.++ "8" (seq.++ "4" (seq.++ "8" (seq.++ "9" (seq.++ "|" ""))))))))))))))))

(assert (= regexA (re.++ (re.opt (str.to_re (seq.++ "1" (seq.++ " " ""))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
