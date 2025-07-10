;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\d?)|(([-+]?\d+\.?\d*)|([-+]?\d*\.?\d+))|(([-+]?\d+\.?\d*\,\ ?)*([-+]?\d+\.?\d*))|(([-+]?\d*\.?\d+\,\ ?)*([-+]?\d*\.?\d+))|(([-+]?\d+\.?\d*\,\ ?)*([-+]?\d*\.?\d+))|(([-+]?\d*\.?\d+\,\ ?)*([-+]?\d+\.?\d*)))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0.8,+8327"
(define-fun Witness1 () String (str.++ "0" (str.++ "." (str.++ "8" (str.++ "," (str.++ "+" (str.++ "8" (str.++ "3" (str.++ "2" (str.++ "7" ""))))))))))
;witness2: "-38,+18.58"
(define-fun Witness2 () String (str.++ "-" (str.++ "3" (str.++ "8" (str.++ "," (str.++ "+" (str.++ "1" (str.++ "8" (str.++ "." (str.++ "5" (str.++ "8" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.opt (re.range "0" "9"))(re.union (re.union (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.* (re.range "0" "9"))))) (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.+ (re.range "0" "9"))))))(re.union (re.++ (re.* (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "," ",") (re.opt (re.range " " " ")))))))) (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.* (re.range "0" "9"))))))(re.union (re.++ (re.* (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "," ",") (re.opt (re.range " " " ")))))))) (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.+ (re.range "0" "9"))))))(re.union (re.++ (re.* (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "," ",") (re.opt (re.range " " " ")))))))) (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.+ (re.range "0" "9")))))) (re.++ (re.* (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "," ",") (re.opt (re.range " " " ")))))))) (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.* (re.range "0" "9"))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
