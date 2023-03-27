;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\#?[A-Fa-f0-9]{3}([A-Fa-f0-9]{3})?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "#29AE3B"
(define-fun Witness1 () String (str.++ "#" (str.++ "2" (str.++ "9" (str.++ "A" (str.++ "E" (str.++ "3" (str.++ "B" ""))))))))
;witness2: "#23e"
(define-fun Witness2 () String (str.++ "#" (str.++ "2" (str.++ "3" (str.++ "e" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "#" "#"))(re.++ ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
