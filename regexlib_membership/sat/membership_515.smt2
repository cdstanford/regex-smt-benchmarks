;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = style="[^"]*"|'[^']*'
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "style=\"\x12\u00E3\u00F18\u0082\"D"
(define-fun Witness1 () String (str.++ "s" (str.++ "t" (str.++ "y" (str.++ "l" (str.++ "e" (str.++ "=" (str.++ "\u{22}" (str.++ "\u{12}" (str.++ "\u{e3}" (str.++ "\u{f1}" (str.++ "8" (str.++ "\u{82}" (str.++ "\u{22}" (str.++ "D" "")))))))))))))))
;witness2: "\'\'"
(define-fun Witness2 () String (str.++ "'" (str.++ "'" "")))

(assert (= regexA (re.union (re.++ (str.to_re (str.++ "s" (str.++ "t" (str.++ "y" (str.++ "l" (str.++ "e" (str.++ "=" (str.++ "\u{22}" ""))))))))(re.++ (re.* (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}"))) (re.range "\u{22}" "\u{22}"))) (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\u{00}" "&") (re.range "(" "\u{ff}"))) (re.range "'" "'"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
