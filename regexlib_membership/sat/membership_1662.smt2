;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-z])+.)+[A-Z]([a-z])+$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "pl\x19pyb\u00DDLtc"
(define-fun Witness1 () String (str.++ "p" (str.++ "l" (str.++ "\u{19}" (str.++ "p" (str.++ "y" (str.++ "b" (str.++ "\u{dd}" (str.++ "L" (str.++ "t" (str.++ "c" "")))))))))))
;witness2: "znrcf\u00EFr\u00FCf Hns"
(define-fun Witness2 () String (str.++ "z" (str.++ "n" (str.++ "r" (str.++ "c" (str.++ "f" (str.++ "\u{ef}" (str.++ "r" (str.++ "\u{fc}" (str.++ "f" (str.++ " " (str.++ "H" (str.++ "n" (str.++ "s" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.+ (re.range "a" "z")) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))(re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
