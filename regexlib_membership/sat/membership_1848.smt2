;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z]{2}[0-9]{6}[A-Za-z]{1}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Zu888584W"
(define-fun Witness1 () String (seq.++ "Z" (seq.++ "u" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "5" (seq.++ "8" (seq.++ "4" (seq.++ "W" ""))))))))))
;witness2: "Ge481919u"
(define-fun Witness2 () String (seq.++ "G" (seq.++ "e" (seq.++ "4" (seq.++ "8" (seq.++ "1" (seq.++ "9" (seq.++ "1" (seq.++ "9" (seq.++ "u" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
