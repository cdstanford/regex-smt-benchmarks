;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^DOMAIN\\\w+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "DOMAIN\\u00CD\u00AA\u00AAA8\u00D0"
(define-fun Witness1 () String (seq.++ "D" (seq.++ "O" (seq.++ "M" (seq.++ "A" (seq.++ "I" (seq.++ "N" (seq.++ "\x5c" (seq.++ "\xcd" (seq.++ "\xaa" (seq.++ "\xaa" (seq.++ "A" (seq.++ "8" (seq.++ "\xd0" ""))))))))))))))
;witness2: "DOMAIN\39"
(define-fun Witness2 () String (seq.++ "D" (seq.++ "O" (seq.++ "M" (seq.++ "A" (seq.++ "I" (seq.++ "N" (seq.++ "\x5c" (seq.++ "3" (seq.++ "9" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "D" (seq.++ "O" (seq.++ "M" (seq.++ "A" (seq.++ "I" (seq.++ "N" (seq.++ "\x5c" ""))))))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
