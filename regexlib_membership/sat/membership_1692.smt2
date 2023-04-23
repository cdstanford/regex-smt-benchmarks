;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (([01][\.\- +]\(\d{3}\)[\.\- +]?)|([01][\.\- +]\d{3}[\.\- +])|(\(\d{3}\) ?)|(\d{3}[- \.]))?\d{3}[- \.]\d{4}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\xD258 848-8888"
(define-fun Witness1 () String (str.++ "\u{0d}" (str.++ "2" (str.++ "5" (str.++ "8" (str.++ " " (str.++ "8" (str.++ "4" (str.++ "8" (str.++ "-" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "8" ""))))))))))))))
;witness2: "993-699 8286"
(define-fun Witness2 () String (str.++ "9" (str.++ "9" (str.++ "3" (str.++ "-" (str.++ "6" (str.++ "9" (str.++ "9" (str.++ " " (str.++ "8" (str.++ "2" (str.++ "8" (str.++ "6" "")))))))))))))

(assert (= regexA (re.++ (re.opt (re.union (re.++ (re.range "0" "1")(re.++ (re.union (re.range " " " ")(re.union (re.range "+" "+") (re.range "-" ".")))(re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range ")" ")") (re.opt (re.union (re.range " " " ")(re.union (re.range "+" "+") (re.range "-" ".")))))))))(re.union (re.++ (re.range "0" "1")(re.++ (re.union (re.range " " " ")(re.union (re.range "+" "+") (re.range "-" ".")))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.union (re.range " " " ")(re.union (re.range "+" "+") (re.range "-" "."))))))(re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range ")" ")") (re.opt (re.range " " " "))))) (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.union (re.range " " " ") (re.range "-" ".")))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range " " " ") (re.range "-" ".")) ((_ re.loop 4 4) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
