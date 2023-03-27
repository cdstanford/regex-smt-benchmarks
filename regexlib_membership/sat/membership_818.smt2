;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z]{2}[ ]{0,1}[0-9]{2}[ ]{0,1}[a-zA-Z]{3}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "nq 51 CZZ"
(define-fun Witness1 () String (str.++ "n" (str.++ "q" (str.++ " " (str.++ "5" (str.++ "1" (str.++ " " (str.++ "C" (str.++ "Z" (str.++ "Z" ""))))))))))
;witness2: "qF 28BzT"
(define-fun Witness2 () String (str.++ "q" (str.++ "F" (str.++ " " (str.++ "2" (str.++ "8" (str.++ "B" (str.++ "z" (str.++ "T" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 3 3) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
