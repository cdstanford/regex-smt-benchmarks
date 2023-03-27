;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <blockquote>(?:\s*([^<]+)<br>\s*)+</blockquote>
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "4<blockquote>\u0085\u00BE<br>\u0085\u00DE\x1A\x6<br> \x9 \u00A0y<br></blockquote>"
(define-fun Witness1 () String (str.++ "4" (str.++ "<" (str.++ "b" (str.++ "l" (str.++ "o" (str.++ "c" (str.++ "k" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ "e" (str.++ ">" (str.++ "\u{85}" (str.++ "\u{be}" (str.++ "<" (str.++ "b" (str.++ "r" (str.++ ">" (str.++ "\u{85}" (str.++ "\u{de}" (str.++ "\u{1a}" (str.++ "\u{06}" (str.++ "<" (str.++ "b" (str.++ "r" (str.++ ">" (str.++ " " (str.++ "\u{09}" (str.++ " " (str.++ "\u{a0}" (str.++ "y" (str.++ "<" (str.++ "b" (str.++ "r" (str.++ ">" (str.++ "<" (str.++ "/" (str.++ "b" (str.++ "l" (str.++ "o" (str.++ "c" (str.++ "k" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ "e" (str.++ ">" ""))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "\u00DE<blockquote>\u0085 \xD \u00CE\u00D92<br></blockquote>\x1"
(define-fun Witness2 () String (str.++ "\u{de}" (str.++ "<" (str.++ "b" (str.++ "l" (str.++ "o" (str.++ "c" (str.++ "k" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ "e" (str.++ ">" (str.++ "\u{85}" (str.++ " " (str.++ "\u{0d}" (str.++ " " (str.++ "\u{ce}" (str.++ "\u{d9}" (str.++ "2" (str.++ "<" (str.++ "b" (str.++ "r" (str.++ ">" (str.++ "<" (str.++ "/" (str.++ "b" (str.++ "l" (str.++ "o" (str.++ "c" (str.++ "k" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ "e" (str.++ ">" (str.++ "\u{01}" "")))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "<" (str.++ "b" (str.++ "l" (str.++ "o" (str.++ "c" (str.++ "k" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ "e" (str.++ ">" "")))))))))))))(re.++ (re.+ (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "\u{00}" ";") (re.range "=" "\u{ff}")))(re.++ (str.to_re (str.++ "<" (str.++ "b" (str.++ "r" (str.++ ">" ""))))) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))) (str.to_re (str.++ "<" (str.++ "/" (str.++ "b" (str.++ "l" (str.++ "o" (str.++ "c" (str.++ "k" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ "e" (str.++ ">" ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
