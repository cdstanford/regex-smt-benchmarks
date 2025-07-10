;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])([Z]|\.[0-9]{4}|[-|\+]([0-1][0-9]|2[0-3]):([0-5][0-9]))?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "03:53:49Z"
(define-fun Witness1 () String (str.++ "0" (str.++ "3" (str.++ ":" (str.++ "5" (str.++ "3" (str.++ ":" (str.++ "4" (str.++ "9" (str.++ "Z" ""))))))))))
;witness2: "23:39:19"
(define-fun Witness2 () String (str.++ "2" (str.++ "3" (str.++ ":" (str.++ "3" (str.++ "9" (str.++ ":" (str.++ "1" (str.++ "9" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "Z" "Z")(re.union (re.++ (re.range "." ".") ((_ re.loop 4 4) (re.range "0" "9"))) (re.++ (re.union (re.range "+" "+")(re.union (re.range "-" "-") (re.range "|" "|")))(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":") (re.++ (re.range "0" "5") (re.range "0" "9")))))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
