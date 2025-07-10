;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (NOT)?(\s*\(*)\s*(\w+)\s*(=|&lt;&gt;|&lt;|&gt;|LIKE|IN)\s*(\(([^\)]*)\)|'([^']*)'|(-?\d*\.?\d+))(\s*\)*\s*)(AND|OR)?
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(( \u0085\u00852\x9&lt;&gt; \xD\u00A0(Q-\u00D4) )\u00A0\u0085AND"
(define-fun Witness1 () String (str.++ "(" (str.++ "(" (str.++ " " (str.++ "\u{85}" (str.++ "\u{85}" (str.++ "2" (str.++ "\u{09}" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" (str.++ " " (str.++ "\u{0d}" (str.++ "\u{a0}" (str.++ "(" (str.++ "Q" (str.++ "-" (str.++ "\u{d4}" (str.++ ")" (str.++ " " (str.++ ")" (str.++ "\u{a0}" (str.++ "\u{85}" (str.++ "A" (str.++ "N" (str.++ "D" "")))))))))))))))))))))))))))))))
;witness2: "\xC\u00C3NOT\u0085\xD0= \xD \u00A0\xD\u00A0\xD\u00A0\x9\'\' \xC \x9))AND:\x2\u00C8\u0096"
(define-fun Witness2 () String (str.++ "\u{0c}" (str.++ "\u{c3}" (str.++ "N" (str.++ "O" (str.++ "T" (str.++ "\u{85}" (str.++ "\u{0d}" (str.++ "0" (str.++ "=" (str.++ " " (str.++ "\u{0d}" (str.++ " " (str.++ "\u{a0}" (str.++ "\u{0d}" (str.++ "\u{a0}" (str.++ "\u{0d}" (str.++ "\u{a0}" (str.++ "\u{09}" (str.++ "'" (str.++ "'" (str.++ " " (str.++ "\u{0c}" (str.++ " " (str.++ "\u{09}" (str.++ ")" (str.++ ")" (str.++ "A" (str.++ "N" (str.++ "D" (str.++ ":" (str.++ "\u{02}" (str.++ "\u{c8}" (str.++ "\u{96}" ""))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (str.to_re (str.++ "N" (str.++ "O" (str.++ "T" "")))))(re.++ (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.* (re.range "(" "(")))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.range "=" "=")(re.union (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))(re.union (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" "")))))(re.union (str.to_re (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))(re.union (str.to_re (str.++ "L" (str.++ "I" (str.++ "K" (str.++ "E" ""))))) (str.to_re (str.++ "I" (str.++ "N" ""))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.++ (re.range "(" "(")(re.++ (re.* (re.union (re.range "\u{00}" "(") (re.range "*" "\u{ff}"))) (re.range ")" ")")))(re.union (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\u{00}" "&") (re.range "(" "\u{ff}"))) (re.range "'" "'"))) (re.++ (re.opt (re.range "-" "-"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.+ (re.range "0" "9")))))))(re.++ (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.* (re.range ")" ")")) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))) (re.opt (re.union (str.to_re (str.++ "A" (str.++ "N" (str.++ "D" "")))) (str.to_re (str.++ "O" (str.++ "R" ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
