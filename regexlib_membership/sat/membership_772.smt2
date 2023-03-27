;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <img[^>]*src=\"?([^\"]*)\"?([^>]*alt=\"?([^\"]*)\"?)?[^>]*>
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "4n<imgsrc=H\u0081\"alt=qP\u00ED\">%G"
(define-fun Witness1 () String (str.++ "4" (str.++ "n" (str.++ "<" (str.++ "i" (str.++ "m" (str.++ "g" (str.++ "s" (str.++ "r" (str.++ "c" (str.++ "=" (str.++ "H" (str.++ "\u{81}" (str.++ "\u{22}" (str.++ "a" (str.++ "l" (str.++ "t" (str.++ "=" (str.++ "q" (str.++ "P" (str.++ "\u{ed}" (str.++ "\u{22}" (str.++ ">" (str.++ "%" (str.++ "G" "")))))))))))))))))))))))))
;witness2: "<imgsrc=\"\u0085\u009FW\"\u008B>"
(define-fun Witness2 () String (str.++ "<" (str.++ "i" (str.++ "m" (str.++ "g" (str.++ "s" (str.++ "r" (str.++ "c" (str.++ "=" (str.++ "\u{22}" (str.++ "\u{85}" (str.++ "\u{9f}" (str.++ "W" (str.++ "\u{22}" (str.++ "\u{8b}" (str.++ ">" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "<" (str.++ "i" (str.++ "m" (str.++ "g" "")))))(re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}")))(re.++ (str.to_re (str.++ "s" (str.++ "r" (str.++ "c" (str.++ "=" "")))))(re.++ (re.opt (re.range "\u{22}" "\u{22}"))(re.++ (re.* (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}")))(re.++ (re.opt (re.range "\u{22}" "\u{22}"))(re.++ (re.opt (re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}")))(re.++ (str.to_re (str.++ "a" (str.++ "l" (str.++ "t" (str.++ "=" "")))))(re.++ (re.opt (re.range "\u{22}" "\u{22}"))(re.++ (re.* (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}"))) (re.opt (re.range "\u{22}" "\u{22}")))))))(re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}"))) (re.range ">" ">")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
