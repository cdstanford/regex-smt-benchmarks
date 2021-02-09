;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\d?)|(([-+]?\d+\.?\d*)|([-+]?\d*\.?\d+))|(([-+]?\d+\.?\d*\,\ ?)*([-+]?\d+\.?\d*))|(([-+]?\d*\.?\d+\,\ ?)*([-+]?\d*\.?\d+))|(([-+]?\d+\.?\d*\,\ ?)*([-+]?\d*\.?\d+))|(([-+]?\d*\.?\d+\,\ ?)*([-+]?\d+\.?\d*)))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0.8,+8327"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "." (seq.++ "8" (seq.++ "," (seq.++ "+" (seq.++ "8" (seq.++ "3" (seq.++ "2" (seq.++ "7" ""))))))))))
;witness2: "-38,+18.58"
(define-fun Witness2 () String (seq.++ "-" (seq.++ "3" (seq.++ "8" (seq.++ "," (seq.++ "+" (seq.++ "1" (seq.++ "8" (seq.++ "." (seq.++ "5" (seq.++ "8" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.opt (re.range "0" "9"))(re.union (re.union (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.* (re.range "0" "9"))))) (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.+ (re.range "0" "9"))))))(re.union (re.++ (re.* (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "," ",") (re.opt (re.range " " " ")))))))) (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.* (re.range "0" "9"))))))(re.union (re.++ (re.* (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "," ",") (re.opt (re.range " " " ")))))))) (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.+ (re.range "0" "9"))))))(re.union (re.++ (re.* (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "," ",") (re.opt (re.range " " " ")))))))) (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.+ (re.range "0" "9")))))) (re.++ (re.* (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "," ",") (re.opt (re.range " " " ")))))))) (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.* (re.range "0" "9"))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
