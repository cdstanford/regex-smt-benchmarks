;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^.*(yourdomain.com).*$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "I\u00D3-\u00EB\x17yourdomain,com"
(define-fun Witness1 () String (str.++ "I" (str.++ "\u{d3}" (str.++ "-" (str.++ "\u{eb}" (str.++ "\u{17}" (str.++ "y" (str.++ "o" (str.++ "u" (str.++ "r" (str.++ "d" (str.++ "o" (str.++ "m" (str.++ "a" (str.++ "i" (str.++ "n" (str.++ "," (str.++ "c" (str.++ "o" (str.++ "m" ""))))))))))))))))))))
;witness2: "x\u00E1\x9yourdomain\u00ECcom"
(define-fun Witness2 () String (str.++ "x" (str.++ "\u{e1}" (str.++ "\u{09}" (str.++ "y" (str.++ "o" (str.++ "u" (str.++ "r" (str.++ "d" (str.++ "o" (str.++ "m" (str.++ "a" (str.++ "i" (str.++ "n" (str.++ "\u{ec}" (str.++ "c" (str.++ "o" (str.++ "m" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.++ (str.to_re (str.++ "y" (str.++ "o" (str.++ "u" (str.++ "r" (str.++ "d" (str.++ "o" (str.++ "m" (str.++ "a" (str.++ "i" (str.++ "n" "")))))))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "c" (str.++ "o" (str.++ "m" ""))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
