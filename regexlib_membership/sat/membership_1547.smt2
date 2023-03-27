;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^DOMAIN\\\w+$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "DOMAIN\\u00CD\u00AA\u00AAA8\u00D0"
(define-fun Witness1 () String (str.++ "D" (str.++ "O" (str.++ "M" (str.++ "A" (str.++ "I" (str.++ "N" (str.++ "\u{5c}" (str.++ "\u{cd}" (str.++ "\u{aa}" (str.++ "\u{aa}" (str.++ "A" (str.++ "8" (str.++ "\u{d0}" ""))))))))))))))
;witness2: "DOMAIN\39"
(define-fun Witness2 () String (str.++ "D" (str.++ "O" (str.++ "M" (str.++ "A" (str.++ "I" (str.++ "N" (str.++ "\u{5c}" (str.++ "3" (str.++ "9" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "D" (str.++ "O" (str.++ "M" (str.++ "A" (str.++ "I" (str.++ "N" (str.++ "\u{5c}" ""))))))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
