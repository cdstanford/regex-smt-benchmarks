;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z]{2}[0-9]{6}[A-Za-z]{1}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Zu888584W"
(define-fun Witness1 () String (str.++ "Z" (str.++ "u" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "5" (str.++ "8" (str.++ "4" (str.++ "W" ""))))))))))
;witness2: "Ge481919u"
(define-fun Witness2 () String (str.++ "G" (str.++ "e" (str.++ "4" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "1" (str.++ "9" (str.++ "u" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
