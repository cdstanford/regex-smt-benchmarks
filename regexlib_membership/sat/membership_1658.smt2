;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((4\d{3})|(5[1-5]\d{2}))(-?|\040?)(\d{4}(-?|\040?)){3}|^(3[4,7]\d{2})(-?|\040?)\d{6}(-?|\040?)\d{5}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "3,18 809795 87888"
(define-fun Witness1 () String (str.++ "3" (str.++ "," (str.++ "1" (str.++ "8" (str.++ " " (str.++ "8" (str.++ "0" (str.++ "9" (str.++ "7" (str.++ "9" (str.++ "5" (str.++ " " (str.++ "8" (str.++ "7" (str.++ "8" (str.++ "8" (str.++ "8" ""))))))))))))))))))
;witness2: "5189-86388816-8889-"
(define-fun Witness2 () String (str.++ "5" (str.++ "1" (str.++ "8" (str.++ "9" (str.++ "-" (str.++ "8" (str.++ "6" (str.++ "3" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "1" (str.++ "6" (str.++ "-" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "-" ""))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "4" "4") ((_ re.loop 3 3) (re.range "0" "9"))) (re.++ (re.range "5" "5")(re.++ (re.range "1" "5") ((_ re.loop 2 2) (re.range "0" "9")))))(re.++ (re.union (re.opt (re.range "-" "-")) (re.opt (re.range " " " "))) ((_ re.loop 3 3) (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.union (re.opt (re.range "-" "-")) (re.opt (re.range " " " ")))))))) (re.++ (str.to_re "")(re.++ (re.++ (re.range "3" "3")(re.++ (re.union (re.range "," ",")(re.union (re.range "4" "4") (re.range "7" "7"))) ((_ re.loop 2 2) (re.range "0" "9"))))(re.++ (re.union (re.opt (re.range "-" "-")) (re.opt (re.range " " " ")))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.union (re.opt (re.range "-" "-")) (re.opt (re.range " " " "))) ((_ re.loop 5 5) (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
