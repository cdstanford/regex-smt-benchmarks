;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^#?(([a-fA-F0-9]{3}){1,2})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "#AFb"
(define-fun Witness1 () String (str.++ "#" (str.++ "A" (str.++ "F" (str.++ "b" "")))))
;witness2: "f80959"
(define-fun Witness2 () String (str.++ "f" (str.++ "8" (str.++ "0" (str.++ "9" (str.++ "5" (str.++ "9" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "#" "#"))(re.++ ((_ re.loop 1 2) ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
