;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(1?(?: |\-|\.)?(?:\(\d{3}\)|\d{3})(?: |\-|\.)?\d{3}(?: |\-|\.)?\d{4})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1558997-9987"
(define-fun Witness1 () String (str.++ "1" (str.++ "5" (str.++ "5" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "7" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "7" "")))))))))))))
;witness2: "1(896)9899998"
(define-fun Witness2 () String (str.++ "1" (str.++ "(" (str.++ "8" (str.++ "9" (str.++ "6" (str.++ ")" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "8" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "1" "1"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" ".")))(re.++ (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range ")" ")"))) ((_ re.loop 3 3) (re.range "0" "9")))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" ".")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "."))) ((_ re.loop 4 4) (re.range "0" "9")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
