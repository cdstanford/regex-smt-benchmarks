;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<nombre>\D{4})(?<fechanac>\d{6})(?<homoclave>.{1}\D{1}\d{1})?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u008F\u00E0F\u00CB429213\u00FFf4"
(define-fun Witness1 () String (seq.++ "\x8f" (seq.++ "\xe0" (seq.++ "F" (seq.++ "\xcb" (seq.++ "4" (seq.++ "2" (seq.++ "9" (seq.++ "2" (seq.++ "1" (seq.++ "3" (seq.++ "\xff" (seq.++ "f" (seq.++ "4" ""))))))))))))))
;witness2: ":\u00E6I\u00D5821983"
(define-fun Witness2 () String (seq.++ ":" (seq.++ "\xe6" (seq.++ "I" (seq.++ "\xd5" (seq.++ "8" (seq.++ "2" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "3" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.union (re.range "\x00" "/") (re.range ":" "\xff")))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.union (re.range "\x00" "/") (re.range ":" "\xff")) (re.range "0" "9")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
