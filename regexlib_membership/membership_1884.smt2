;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{4}[- ]){3}\d{4}|\d{16}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "7888 9378-7591 0790\u008C\u009D\u00C7"
(define-fun Witness1 () String (str.++ "7" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ " " (str.++ "9" (str.++ "3" (str.++ "7" (str.++ "8" (str.++ "-" (str.++ "7" (str.++ "5" (str.++ "9" (str.++ "1" (str.++ " " (str.++ "0" (str.++ "7" (str.++ "9" (str.++ "0" (str.++ "\u{8c}" (str.++ "\u{9d}" (str.++ "\u{c7}" "")))))))))))))))))))))))
;witness2: "8840995742186638"
(define-fun Witness2 () String (str.++ "8" (str.++ "8" (str.++ "4" (str.++ "0" (str.++ "9" (str.++ "9" (str.++ "5" (str.++ "7" (str.++ "4" (str.++ "2" (str.++ "1" (str.++ "8" (str.++ "6" (str.++ "6" (str.++ "3" (str.++ "8" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.union (re.range " " " ") (re.range "-" "-")))) ((_ re.loop 4 4) (re.range "0" "9")))) (re.++ ((_ re.loop 16 16) (re.range "0" "9")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
