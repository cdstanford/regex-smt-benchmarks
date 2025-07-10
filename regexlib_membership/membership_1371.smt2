;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = 12/err
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "|\u009412/err"
(define-fun Witness1 () String (str.++ "|" (str.++ "\u{94}" (str.++ "1" (str.++ "2" (str.++ "/" (str.++ "e" (str.++ "r" (str.++ "r" "")))))))))
;witness2: "12/err"
(define-fun Witness2 () String (str.++ "1" (str.++ "2" (str.++ "/" (str.++ "e" (str.++ "r" (str.++ "r" "")))))))

(assert (= regexA (str.to_re (str.++ "1" (str.++ "2" (str.++ "/" (str.++ "e" (str.++ "r" (str.++ "r" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
