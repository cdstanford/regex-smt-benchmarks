;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [a-z0-9][a-z0-9-]*[a-z0-9](?:\.[a-z0-9][a-z0-9-]*[a-z0-9])+
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "kf.61hd"
(define-fun Witness1 () String (str.++ "k" (str.++ "f" (str.++ "." (str.++ "6" (str.++ "1" (str.++ "h" (str.++ "d" ""))))))))
;witness2: "\u00F9\u00EB~7a.89.8-3"
(define-fun Witness2 () String (str.++ "\u{f9}" (str.++ "\u{eb}" (str.++ "~" (str.++ "7" (str.++ "a" (str.++ "." (str.++ "8" (str.++ "9" (str.++ "." (str.++ "8" (str.++ "-" (str.++ "3" "")))))))))))))

(assert (= regexA (re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.union (re.range "0" "9") (re.range "a" "z")) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))) (re.union (re.range "0" "9") (re.range "a" "z")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
