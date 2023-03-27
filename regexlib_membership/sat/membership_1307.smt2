;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\+?[a-z0-9](([-+.]|[_]+)?[a-z0-9]+)*@([a-z0-9]+(\.|\-))+[a-z]{2,6}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+xy@81-eyy"
(define-fun Witness1 () String (str.++ "+" (str.++ "x" (str.++ "y" (str.++ "@" (str.++ "8" (str.++ "1" (str.++ "-" (str.++ "e" (str.++ "y" (str.++ "y" "")))))))))))
;witness2: "3a0@8f-m.a.q6-ms"
(define-fun Witness2 () String (str.++ "3" (str.++ "a" (str.++ "0" (str.++ "@" (str.++ "8" (str.++ "f" (str.++ "-" (str.++ "m" (str.++ "." (str.++ "a" (str.++ "." (str.++ "q" (str.++ "6" (str.++ "-" (str.++ "m" (str.++ "s" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "+" "+"))(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.++ (re.opt (re.union (re.union (re.range "+" "+") (re.range "-" ".")) (re.+ (re.range "_" "_")))) (re.+ (re.union (re.range "0" "9") (re.range "a" "z")))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.range "-" ".")))(re.++ ((_ re.loop 2 6) (re.range "a" "z")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
