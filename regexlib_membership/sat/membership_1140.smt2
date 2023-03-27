;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9a-fA-F]{4}|0)(\:([0-9a-fA-F]{4}|0)){7}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "4988:b07C:0:0:0:5D9F:0:0"
(define-fun Witness1 () String (str.++ "4" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ ":" (str.++ "b" (str.++ "0" (str.++ "7" (str.++ "C" (str.++ ":" (str.++ "0" (str.++ ":" (str.++ "0" (str.++ ":" (str.++ "0" (str.++ ":" (str.++ "5" (str.++ "D" (str.++ "9" (str.++ "F" (str.++ ":" (str.++ "0" (str.++ ":" (str.++ "0" "")))))))))))))))))))))))))
;witness2: "f98a:8843:0:8DA5:0:4498:0:8cb8"
(define-fun Witness2 () String (str.++ "f" (str.++ "9" (str.++ "8" (str.++ "a" (str.++ ":" (str.++ "8" (str.++ "8" (str.++ "4" (str.++ "3" (str.++ ":" (str.++ "0" (str.++ ":" (str.++ "8" (str.++ "D" (str.++ "A" (str.++ "5" (str.++ ":" (str.++ "0" (str.++ ":" (str.++ "4" (str.++ "4" (str.++ "9" (str.++ "8" (str.++ ":" (str.++ "0" (str.++ ":" (str.++ "8" (str.++ "c" (str.++ "b" (str.++ "8" "")))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range "0" "0"))(re.++ ((_ re.loop 7 7) (re.++ (re.range ":" ":") (re.union ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range "0" "0")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
