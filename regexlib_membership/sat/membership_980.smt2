;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <img[^>]* src=\"([^\"]*)\"[^>]*>
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "|<img\u00DE src=\"\"g\u00A8>"
(define-fun Witness1 () String (str.++ "|" (str.++ "<" (str.++ "i" (str.++ "m" (str.++ "g" (str.++ "\u{de}" (str.++ " " (str.++ "s" (str.++ "r" (str.++ "c" (str.++ "=" (str.++ "\u{22}" (str.++ "\u{22}" (str.++ "g" (str.++ "\u{a8}" (str.++ ">" "")))))))))))))))))
;witness2: "<img\u00D0% src=\"\"i>\u0093oH"
(define-fun Witness2 () String (str.++ "<" (str.++ "i" (str.++ "m" (str.++ "g" (str.++ "\u{d0}" (str.++ "%" (str.++ " " (str.++ "s" (str.++ "r" (str.++ "c" (str.++ "=" (str.++ "\u{22}" (str.++ "\u{22}" (str.++ "i" (str.++ ">" (str.++ "\u{93}" (str.++ "o" (str.++ "H" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "<" (str.++ "i" (str.++ "m" (str.++ "g" "")))))(re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}")))(re.++ (str.to_re (str.++ " " (str.++ "s" (str.++ "r" (str.++ "c" (str.++ "=" (str.++ "\u{22}" "")))))))(re.++ (re.* (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}")))(re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}"))) (re.range ">" ">")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
