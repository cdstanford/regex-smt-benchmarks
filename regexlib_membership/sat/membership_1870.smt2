;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [0-9]{4}\s*[a-zA-Z]{2}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1488\u00A0xJs"
(define-fun Witness1 () String (str.++ "1" (str.++ "4" (str.++ "8" (str.++ "8" (str.++ "\u{a0}" (str.++ "x" (str.++ "J" (str.++ "s" "")))))))))
;witness2: "5499\xC\u0085 XL\x2%"
(define-fun Witness2 () String (str.++ "5" (str.++ "4" (str.++ "9" (str.++ "9" (str.++ "\u{0c}" (str.++ "\u{85}" (str.++ " " (str.++ "X" (str.++ "L" (str.++ "\u{02}" (str.++ "%" ""))))))))))))

(assert (= regexA (re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
