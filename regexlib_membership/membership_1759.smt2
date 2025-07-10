;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <img([^>]*[^/])>
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "o<img\u0083a>"
(define-fun Witness1 () String (str.++ "o" (str.++ "<" (str.++ "i" (str.++ "m" (str.++ "g" (str.++ "\u{83}" (str.++ "a" (str.++ ">" "")))))))))
;witness2: "<img\xF\u00ED\u00BF>\u00C2"
(define-fun Witness2 () String (str.++ "<" (str.++ "i" (str.++ "m" (str.++ "g" (str.++ "\u{0f}" (str.++ "\u{ed}" (str.++ "\u{bf}" (str.++ ">" (str.++ "\u{c2}" ""))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "<" (str.++ "i" (str.++ "m" (str.++ "g" "")))))(re.++ (re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}"))) (re.union (re.range "\u{00}" ".") (re.range "0" "\u{ff}"))) (re.range ">" ">")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
