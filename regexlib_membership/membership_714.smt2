;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\${1}[a-z]{1}[a-z\d]{0,6}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "$nxc"
(define-fun Witness1 () String (str.++ "$" (str.++ "n" (str.++ "x" (str.++ "c" "")))))
;witness2: "$zp"
(define-fun Witness2 () String (str.++ "$" (str.++ "z" (str.++ "p" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "$" "$")(re.++ (re.range "a" "z")(re.++ ((_ re.loop 0 6) (re.union (re.range "0" "9") (re.range "a" "z"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
