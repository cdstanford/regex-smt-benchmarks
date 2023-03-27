;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)+$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-@o--.9"
(define-fun Witness1 () String (str.++ "-" (str.++ "@" (str.++ "o" (str.++ "-" (str.++ "-" (str.++ "." (str.++ "9" ""))))))))
;witness2: "8._6.r.1--@x1.98.-"
(define-fun Witness2 () String (str.++ "8" (str.++ "." (str.++ "_" (str.++ "6" (str.++ "." (str.++ "r" (str.++ "." (str.++ "1" (str.++ "-" (str.++ "-" (str.++ "@" (str.++ "x" (str.++ "1" (str.++ "." (str.++ "9" (str.++ "8" (str.++ "." (str.++ "-" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.+ (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
