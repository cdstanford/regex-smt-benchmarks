;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([0-9]{3})[ \-\/]?([0-9]{3})[ \-\/]?([0-9]{3}))|([0-9]{9})|([\+]?([0-9]{3})[ \-\/]?([0-9]{2})[ \-\/]?([0-9]{3})[ \-\/]?([0-9]{3}))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "266680 959+"
(define-fun Witness1 () String (str.++ "2" (str.++ "6" (str.++ "6" (str.++ "6" (str.++ "8" (str.++ "0" (str.++ " " (str.++ "9" (str.++ "5" (str.++ "9" (str.++ "+" ""))))))))))))
;witness2: "+81789 998 307"
(define-fun Witness2 () String (str.++ "+" (str.++ "8" (str.++ "1" (str.++ "7" (str.++ "8" (str.++ "9" (str.++ " " (str.++ "9" (str.++ "9" (str.++ "8" (str.++ " " (str.++ "3" (str.++ "0" (str.++ "7" "")))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "/" "/"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "/" "/")))) ((_ re.loop 3 3) (re.range "0" "9")))))))(re.union ((_ re.loop 9 9) (re.range "0" "9")) (re.++ (re.++ (re.opt (re.range "+" "+"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "/" "/"))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "/" "/"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "/" "/")))) ((_ re.loop 3 3) (re.range "0" "9"))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
