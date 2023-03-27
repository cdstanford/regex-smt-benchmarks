;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (((s*)(ftp)(s*)|(http)(s*)|mailto|news|file|webcal):(\S*))|((www.)(\S*))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "www\x1Fq\u00CC\u00A6\u00B4"
(define-fun Witness1 () String (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "\u{1f}" (str.++ "q" (str.++ "\u{cc}" (str.++ "\u{a6}" (str.++ "\u{b4}" "")))))))))
;witness2: "www\x1ED\u00A6"
(define-fun Witness2 () String (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "\u{1e}" (str.++ "D" (str.++ "\u{a6}" "")))))))

(assert (= regexA (re.union (re.++ (re.union (re.++ (re.* (re.range "s" "s"))(re.++ (str.to_re (str.++ "f" (str.++ "t" (str.++ "p" "")))) (re.* (re.range "s" "s"))))(re.union (re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" ""))))) (re.* (re.range "s" "s")))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "i" (str.++ "l" (str.++ "t" (str.++ "o" "")))))))(re.union (str.to_re (str.++ "n" (str.++ "e" (str.++ "w" (str.++ "s" "")))))(re.union (str.to_re (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" ""))))) (str.to_re (str.++ "w" (str.++ "e" (str.++ "b" (str.++ "c" (str.++ "a" (str.++ "l" ""))))))))))))(re.++ (re.range ":" ":") (re.* (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))))) (re.++ (re.++ (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" "")))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.* (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
