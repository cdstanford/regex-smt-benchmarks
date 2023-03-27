;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d{5,12}|\d{1,10}\.\d{1,10}\.\d{1,10}|\d{1,10}\.\d{1,10}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x175.0.88"
(define-fun Witness1 () String (str.++ "\u{17}" (str.++ "5" (str.++ "." (str.++ "0" (str.++ "." (str.++ "8" (str.++ "8" ""))))))))
;witness2: "988.18276.2"
(define-fun Witness2 () String (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "." (str.++ "1" (str.++ "8" (str.++ "2" (str.++ "7" (str.++ "6" (str.++ "." (str.++ "2" ""))))))))))))

(assert (= regexA (re.union ((_ re.loop 5 12) (re.range "0" "9"))(re.union (re.++ ((_ re.loop 1 10) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 10) (re.range "0" "9"))(re.++ (re.range "." ".") ((_ re.loop 1 10) (re.range "0" "9")))))) (re.++ ((_ re.loop 1 10) (re.range "0" "9"))(re.++ (re.range "." ".") ((_ re.loop 1 10) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
