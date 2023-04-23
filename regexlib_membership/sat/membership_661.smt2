;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^R(\d){8}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "R88354924\u0086"
(define-fun Witness1 () String (str.++ "R" (str.++ "8" (str.++ "8" (str.++ "3" (str.++ "5" (str.++ "4" (str.++ "9" (str.++ "2" (str.++ "4" (str.++ "\u{86}" "")))))))))))
;witness2: "R98939613"
(define-fun Witness2 () String (str.++ "R" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "3" (str.++ "9" (str.++ "6" (str.++ "1" (str.++ "3" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "R" "R") ((_ re.loop 8 8) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
