;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;img .+ src[ ]*=[ ]*\&quot;(.+)\&quot;
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "[\xB&lt;img p\x7 src =&quot;\u00A9&quot;\x1E\u00F8"
(define-fun Witness1 () String (str.++ "[" (str.++ "\u{0b}" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "i" (str.++ "m" (str.++ "g" (str.++ " " (str.++ "p" (str.++ "\u{07}" (str.++ " " (str.++ "s" (str.++ "r" (str.++ "c" (str.++ " " (str.++ "=" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "\u{a9}" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "\u{1e}" (str.++ "\u{f8}" ""))))))))))))))))))))))))))))))))))
;witness2: "&lt;img \x18\x2+\u0087 src =   &quot;\u009B&quot;"
(define-fun Witness2 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "i" (str.++ "m" (str.++ "g" (str.++ " " (str.++ "\u{18}" (str.++ "\u{02}" (str.++ "+" (str.++ "\u{87}" (str.++ " " (str.++ "s" (str.++ "r" (str.++ "c" (str.++ " " (str.++ "=" (str.++ " " (str.++ " " (str.++ " " (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "\u{9b}" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" "")))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "i" (str.++ "m" (str.++ "g" (str.++ " " "")))))))))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (str.to_re (str.++ " " (str.++ "s" (str.++ "r" (str.++ "c" "")))))(re.++ (re.* (re.range " " " "))(re.++ (re.range "=" "=")(re.++ (re.* (re.range " " " "))(re.++ (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" "")))))))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" "")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
