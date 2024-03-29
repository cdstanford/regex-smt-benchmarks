;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9a-f]{4}\.[0-9a-f]{4}\.[0-9a-f]{4})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "5fc9.0c9f.398e"
(define-fun Witness1 () String (str.++ "5" (str.++ "f" (str.++ "c" (str.++ "9" (str.++ "." (str.++ "0" (str.++ "c" (str.++ "9" (str.++ "f" (str.++ "." (str.++ "3" (str.++ "9" (str.++ "8" (str.++ "e" "")))))))))))))))
;witness2: "1539.9c8f.a9c8"
(define-fun Witness2 () String (str.++ "1" (str.++ "5" (str.++ "3" (str.++ "9" (str.++ "." (str.++ "9" (str.++ "c" (str.++ "8" (str.++ "f" (str.++ "." (str.++ "a" (str.++ "9" (str.++ "c" (str.++ "8" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9") (re.range "a" "f")))(re.++ (re.range "." ".")(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9") (re.range "a" "f")))(re.++ (re.range "." ".") ((_ re.loop 4 4) (re.union (re.range "0" "9") (re.range "a" "f"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
