;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]\:\\.*|^\\\\.*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\\%\u00F8"
(define-fun Witness1 () String (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "%" (seq.++ "\xf8" "")))))
;witness2: "\\"
(define-fun Witness2 () String (seq.++ "\x5c" (seq.++ "\x5c" "")))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (str.to_re (seq.++ ":" (seq.++ "\x5c" ""))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))))) (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "\x5c" (seq.++ "\x5c" ""))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
