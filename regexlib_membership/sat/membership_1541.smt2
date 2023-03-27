;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[D-d][K-k]( |-)[1-9]{1}[0-9]{3}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "ck-8897"
(define-fun Witness1 () String (str.++ "c" (str.++ "k" (str.++ "-" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "7" ""))))))))
;witness2: "d[ 9818"
(define-fun Witness2 () String (str.++ "d" (str.++ "[" (str.++ " " (str.++ "9" (str.++ "8" (str.++ "1" (str.++ "8" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "D" "d")(re.++ (re.range "K" "k")(re.++ (re.union (re.range " " " ") (re.range "-" "-"))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
