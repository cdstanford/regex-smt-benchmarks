;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^.+\|+[A-Za-z])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ";\u0098\u00A2\u00B9\x6||Z"
(define-fun Witness1 () String (seq.++ ";" (seq.++ "\x98" (seq.++ "\xa2" (seq.++ "\xb9" (seq.++ "\x06" (seq.++ "|" (seq.++ "|" (seq.++ "Z" "")))))))))
;witness2: "X||z\xE\u00A8"
(define-fun Witness2 () String (seq.++ "X" (seq.++ "|" (seq.++ "|" (seq.++ "z" (seq.++ "\x0e" (seq.++ "\xa8" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.+ (re.range "|" "|")) (re.union (re.range "A" "Z") (re.range "a" "z")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
