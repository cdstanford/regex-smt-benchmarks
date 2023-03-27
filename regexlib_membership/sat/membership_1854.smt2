;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;[^&gt;]*\n?.*=(&quot;|')?(.*\.jpg)(&quot;|')?.*\n?[^&lt;]*&gt;
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0095\u00CB\u00E1&lt;\xA\u008D=.jpg&quot;&gt;n"
(define-fun Witness1 () String (str.++ "\u{95}" (str.++ "\u{cb}" (str.++ "\u{e1}" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "\u{0a}" (str.++ "\u{8d}" (str.++ "=" (str.++ "." (str.++ "j" (str.++ "p" (str.++ "g" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "n" ""))))))))))))))))))))))))))
;witness2: "&lt;\x19\u00D1\u00B7\u009C\u00D1=.jpg\'f\u0097\u00D0&gt;t"
(define-fun Witness2 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "\u{19}" (str.++ "\u{d1}" (str.++ "\u{b7}" (str.++ "\u{9c}" (str.++ "\u{d1}" (str.++ "=" (str.++ "." (str.++ "j" (str.++ "p" (str.++ "g" (str.++ "'" (str.++ "f" (str.++ "\u{97}" (str.++ "\u{d0}" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ "t" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" "")))))(re.++ (re.* (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\u{ff}"))))))(re.++ (re.opt (re.range "\u{0a}" "\u{0a}"))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "=" "=")(re.++ (re.opt (re.union (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" ""))))))) (re.range "'" "'")))(re.++ (re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re (str.++ "." (str.++ "j" (str.++ "p" (str.++ "g" ""))))))(re.++ (re.opt (re.union (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" ""))))))) (re.range "'" "'")))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.opt (re.range "\u{0a}" "\u{0a}"))(re.++ (re.* (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "k")(re.union (re.range "m" "s") (re.range "u" "\u{ff}")))))) (str.to_re (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
