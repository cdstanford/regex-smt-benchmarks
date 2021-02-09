;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{4}[- ]){3}\d{4}|\d{16}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "7888 9378-7591 0790\u008C\u009D\u00C7"
(define-fun Witness1 () String (seq.++ "7" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ " " (seq.++ "9" (seq.++ "3" (seq.++ "7" (seq.++ "8" (seq.++ "-" (seq.++ "7" (seq.++ "5" (seq.++ "9" (seq.++ "1" (seq.++ " " (seq.++ "0" (seq.++ "7" (seq.++ "9" (seq.++ "0" (seq.++ "\x8c" (seq.++ "\x9d" (seq.++ "\xc7" "")))))))))))))))))))))))
;witness2: "8840995742186638"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "0" (seq.++ "9" (seq.++ "9" (seq.++ "5" (seq.++ "7" (seq.++ "4" (seq.++ "2" (seq.++ "1" (seq.++ "8" (seq.++ "6" (seq.++ "6" (seq.++ "3" (seq.++ "8" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.union (re.range " " " ") (re.range "-" "-")))) ((_ re.loop 4 4) (re.range "0" "9")))) (re.++ ((_ re.loop 16 16) (re.range "0" "9")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
