;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = /*d(9,15)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "d9,15#"
(define-fun Witness1 () String (str.++ "d" (str.++ "9" (str.++ "," (str.++ "1" (str.++ "5" (str.++ "#" "")))))))
;witness2: "fd9,15w"
(define-fun Witness2 () String (str.++ "f" (str.++ "d" (str.++ "9" (str.++ "," (str.++ "1" (str.++ "5" (str.++ "w" ""))))))))

(assert (= regexA (re.++ (re.* (re.range "/" "/"))(re.++ (re.range "d" "d") (str.to_re (str.++ "9" (str.++ "," (str.++ "1" (str.++ "5" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
