;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((((0031)|(\+31))(\-)?6(\-)?[0-9]{8})|(06(\-)?[0-9]{8})|(((0031)|(\+31))(\-)?[1-9]{1}(([0-9](\-)?[0-9]{7})|([0-9]{2}(\-)?[0-9]{6})))|([0]{1}[1-9]{1}(([0-9](\-)?[0-9]{7})|([0-9]{2}(\-)?[0-9]{6}))))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0031-698893395"
(define-fun Witness1 () String (str.++ "0" (str.++ "0" (str.++ "3" (str.++ "1" (str.++ "-" (str.++ "6" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "3" (str.++ "3" (str.++ "9" (str.++ "5" "")))))))))))))))
;witness2: "0879894925"
(define-fun Witness2 () String (str.++ "0" (str.++ "8" (str.++ "7" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "4" (str.++ "9" (str.++ "2" (str.++ "5" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (str.to_re (str.++ "0" (str.++ "0" (str.++ "3" (str.++ "1" ""))))) (str.to_re (str.++ "+" (str.++ "3" (str.++ "1" "")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "6" "6")(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 8 8) (re.range "0" "9"))))))(re.union (re.++ (str.to_re (str.++ "0" (str.++ "6" "")))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 8 8) (re.range "0" "9"))))(re.union (re.++ (re.union (str.to_re (str.++ "0" (str.++ "0" (str.++ "3" (str.++ "1" ""))))) (str.to_re (str.++ "+" (str.++ "3" (str.++ "1" "")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "1" "9") (re.union (re.++ (re.range "0" "9")(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 7 7) (re.range "0" "9")))) (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 6 6) (re.range "0" "9")))))))) (re.++ (re.range "0" "0")(re.++ (re.range "1" "9") (re.union (re.++ (re.range "0" "9")(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 7 7) (re.range "0" "9")))) (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 6 6) (re.range "0" "9")))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
