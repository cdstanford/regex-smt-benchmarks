;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z]{1,2}[0-9A-Za-z]{1,2}[ ]?[0-9]{0,1}[A-Za-z]{2}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "h6e 4Rk"
(define-fun Witness1 () String (str.++ "h" (str.++ "6" (str.++ "e" (str.++ " " (str.++ "4" (str.++ "R" (str.++ "k" ""))))))))
;witness2: "YN88ZB"
(define-fun Witness2 () String (str.++ "Y" (str.++ "N" (str.++ "8" (str.++ "8" (str.++ "Z" (str.++ "B" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 1 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (re.range "0" "9"))(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
