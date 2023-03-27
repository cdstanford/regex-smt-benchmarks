;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<nombre>\D{4})(?<fechanac>\d{6})(?<homoclave>.{1}\D{1}\d{1})?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u008F\u00E0F\u00CB429213\u00FFf4"
(define-fun Witness1 () String (str.++ "\u{8f}" (str.++ "\u{e0}" (str.++ "F" (str.++ "\u{cb}" (str.++ "4" (str.++ "2" (str.++ "9" (str.++ "2" (str.++ "1" (str.++ "3" (str.++ "\u{ff}" (str.++ "f" (str.++ "4" ""))))))))))))))
;witness2: ":\u00E6I\u00D5821983"
(define-fun Witness2 () String (str.++ ":" (str.++ "\u{e6}" (str.++ "I" (str.++ "\u{d5}" (str.++ "8" (str.++ "2" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "3" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}")))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}")) (re.range "0" "9")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
