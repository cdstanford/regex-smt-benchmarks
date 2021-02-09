;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "-@o--.9"
(define-fun Witness1 () String (seq.++ "-" (seq.++ "@" (seq.++ "o" (seq.++ "-" (seq.++ "-" (seq.++ "." (seq.++ "9" ""))))))))
;witness2: "8._6.r.1--@x1.98.-"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "." (seq.++ "_" (seq.++ "6" (seq.++ "." (seq.++ "r" (seq.++ "." (seq.++ "1" (seq.++ "-" (seq.++ "-" (seq.++ "@" (seq.++ "x" (seq.++ "1" (seq.++ "." (seq.++ "9" (seq.++ "8" (seq.++ "." (seq.++ "-" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.+ (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z")))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
