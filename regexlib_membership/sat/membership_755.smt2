;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\({0,1}((0|\+61)(2|4|3|7|8)){0,1}\){0,1}(\ |-){0,1}[0-9]{2}(\ |-){0,1}[0-9]{2}(\ |-){0,1}[0-9]{1}(\ |-){0,1}[0-9]{3}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(+618 58 949866"
(define-fun Witness1 () String (str.++ "(" (str.++ "+" (str.++ "6" (str.++ "1" (str.++ "8" (str.++ " " (str.++ "5" (str.++ "8" (str.++ " " (str.++ "9" (str.++ "4" (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "6" ""))))))))))))))))
;witness2: "042499-1 895"
(define-fun Witness2 () String (str.++ "0" (str.++ "4" (str.++ "2" (str.++ "4" (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "1" (str.++ " " (str.++ "8" (str.++ "9" (str.++ "5" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "(" "("))(re.++ (re.opt (re.++ (re.union (re.range "0" "0") (str.to_re (str.++ "+" (str.++ "6" (str.++ "1" ""))))) (re.union (re.range "2" "4") (re.range "7" "8"))))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ (re.range "0" "9")(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
