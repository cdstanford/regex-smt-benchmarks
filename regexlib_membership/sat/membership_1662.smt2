;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-z])+.)+[A-Z]([a-z])+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "pl\x19pyb\u00DDLtc"
(define-fun Witness1 () String (seq.++ "p" (seq.++ "l" (seq.++ "\x19" (seq.++ "p" (seq.++ "y" (seq.++ "b" (seq.++ "\xdd" (seq.++ "L" (seq.++ "t" (seq.++ "c" "")))))))))))
;witness2: "znrcf\u00EFr\u00FCf Hns"
(define-fun Witness2 () String (seq.++ "z" (seq.++ "n" (seq.++ "r" (seq.++ "c" (seq.++ "f" (seq.++ "\xef" (seq.++ "r" (seq.++ "\xfc" (seq.++ "f" (seq.++ " " (seq.++ "H" (seq.++ "n" (seq.++ "s" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.+ (re.range "a" "z")) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))(re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
