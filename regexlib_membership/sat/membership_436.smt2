;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z]{5})([a-zA-Z0-9-]{3,12})
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "vfvzxSb-u"
(define-fun Witness1 () String (str.++ "v" (str.++ "f" (str.++ "v" (str.++ "z" (str.++ "x" (str.++ "S" (str.++ "b" (str.++ "-" (str.++ "u" ""))))))))))
;witness2: "CErQZy7-\u00FE"
(define-fun Witness2 () String (str.++ "C" (str.++ "E" (str.++ "r" (str.++ "Q" (str.++ "Z" (str.++ "y" (str.++ "7" (str.++ "-" (str.++ "\u{fe}" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.union (re.range "A" "Z") (re.range "a" "z"))) ((_ re.loop 3 12) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
