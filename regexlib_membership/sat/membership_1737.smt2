;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <blockquote>(?:\s*([^<]+)<br>\s*)+</blockquote>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "4<blockquote>\u0085\u00BE<br>\u0085\u00DE\x1A\x6<br> \x9 \u00A0y<br></blockquote>"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "<" (seq.++ "b" (seq.++ "l" (seq.++ "o" (seq.++ "c" (seq.++ "k" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ "e" (seq.++ ">" (seq.++ "\x85" (seq.++ "\xbe" (seq.++ "<" (seq.++ "b" (seq.++ "r" (seq.++ ">" (seq.++ "\x85" (seq.++ "\xde" (seq.++ "\x1a" (seq.++ "\x06" (seq.++ "<" (seq.++ "b" (seq.++ "r" (seq.++ ">" (seq.++ " " (seq.++ "\x09" (seq.++ " " (seq.++ "\xa0" (seq.++ "y" (seq.++ "<" (seq.++ "b" (seq.++ "r" (seq.++ ">" (seq.++ "<" (seq.++ "/" (seq.++ "b" (seq.++ "l" (seq.++ "o" (seq.++ "c" (seq.++ "k" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ "e" (seq.++ ">" ""))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "\u00DE<blockquote>\u0085 \xD \u00CE\u00D92<br></blockquote>\x1"
(define-fun Witness2 () String (seq.++ "\xde" (seq.++ "<" (seq.++ "b" (seq.++ "l" (seq.++ "o" (seq.++ "c" (seq.++ "k" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ "e" (seq.++ ">" (seq.++ "\x85" (seq.++ " " (seq.++ "\x0d" (seq.++ " " (seq.++ "\xce" (seq.++ "\xd9" (seq.++ "2" (seq.++ "<" (seq.++ "b" (seq.++ "r" (seq.++ ">" (seq.++ "<" (seq.++ "/" (seq.++ "b" (seq.++ "l" (seq.++ "o" (seq.++ "c" (seq.++ "k" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ "e" (seq.++ ">" (seq.++ "\x01" "")))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "<" (seq.++ "b" (seq.++ "l" (seq.++ "o" (seq.++ "c" (seq.++ "k" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ "e" (seq.++ ">" "")))))))))))))(re.++ (re.+ (re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "\x00" ";") (re.range "=" "\xff")))(re.++ (str.to_re (seq.++ "<" (seq.++ "b" (seq.++ "r" (seq.++ ">" ""))))) (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))) (str.to_re (seq.++ "<" (seq.++ "/" (seq.++ "b" (seq.++ "l" (seq.++ "o" (seq.++ "c" (seq.++ "k" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ "e" (seq.++ ">" ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
