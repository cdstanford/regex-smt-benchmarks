;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [\+]?[1]?[-. ]?(\(\d{3}\)|\d{3})(|[-. ])?\d{3}(|[-. ])\d{4}|\d{3}(|[-. ])\d{4}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+1(488).283 1997"
(define-fun Witness1 () String (str.++ "+" (str.++ "1" (str.++ "(" (str.++ "4" (str.++ "8" (str.++ "8" (str.++ ")" (str.++ "." (str.++ "2" (str.++ "8" (str.++ "3" (str.++ " " (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "7" "")))))))))))))))))
;witness2: "9648003"
(define-fun Witness2 () String (str.++ "9" (str.++ "6" (str.++ "4" (str.++ "8" (str.++ "0" (str.++ "0" (str.++ "3" ""))))))))

(assert (= regexA (re.union (re.++ (re.opt (re.range "+" "+"))(re.++ (re.opt (re.range "1" "1"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" ".")))(re.++ (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range ")" ")"))) ((_ re.loop 3 3) (re.range "0" "9")))(re.++ (re.opt (re.union (str.to_re "") (re.union (re.range " " " ") (re.range "-" "."))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (str.to_re "") (re.union (re.range " " " ") (re.range "-" "."))) ((_ re.loop 4 4) (re.range "0" "9"))))))))) (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (str.to_re "") (re.union (re.range " " " ") (re.range "-" "."))) ((_ re.loop 4 4) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
