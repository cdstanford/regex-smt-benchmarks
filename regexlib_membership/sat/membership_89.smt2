;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [a-z0-9][a-z0-9-]*[a-z0-9](?:\.[a-z0-9][a-z0-9-]*[a-z0-9])+
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "kf.61hd"
(define-fun Witness1 () String (seq.++ "k" (seq.++ "f" (seq.++ "." (seq.++ "6" (seq.++ "1" (seq.++ "h" (seq.++ "d" ""))))))))
;witness2: "\u00F9\u00EB~7a.89.8-3"
(define-fun Witness2 () String (seq.++ "\xf9" (seq.++ "\xeb" (seq.++ "~" (seq.++ "7" (seq.++ "a" (seq.++ "." (seq.++ "8" (seq.++ "9" (seq.++ "." (seq.++ "8" (seq.++ "-" (seq.++ "3" "")))))))))))))

(assert (= regexA (re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z")) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
