;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (NOT)?(\s*\(*)\s*(\w+)\s*(=|&lt;&gt;|&lt;|&gt;|LIKE|IN)\s*(\(([^\)]*)\)|'([^']*)'|(-?\d*\.?\d+))(\s*\)*\s*)(AND|OR)?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(( \u0085\u00852\x9&lt;&gt; \xD\u00A0(Q-\u00D4) )\u00A0\u0085AND"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "(" (seq.++ " " (seq.++ "\x85" (seq.++ "\x85" (seq.++ "2" (seq.++ "\x09" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ " " (seq.++ "\x0d" (seq.++ "\xa0" (seq.++ "(" (seq.++ "Q" (seq.++ "-" (seq.++ "\xd4" (seq.++ ")" (seq.++ " " (seq.++ ")" (seq.++ "\xa0" (seq.++ "\x85" (seq.++ "A" (seq.++ "N" (seq.++ "D" "")))))))))))))))))))))))))))))))
;witness2: "\xC\u00C3NOT\u0085\xD0= \xD \u00A0\xD\u00A0\xD\u00A0\x9\'\' \xC \x9))AND:\x2\u00C8\u0096"
(define-fun Witness2 () String (seq.++ "\x0c" (seq.++ "\xc3" (seq.++ "N" (seq.++ "O" (seq.++ "T" (seq.++ "\x85" (seq.++ "\x0d" (seq.++ "0" (seq.++ "=" (seq.++ " " (seq.++ "\x0d" (seq.++ " " (seq.++ "\xa0" (seq.++ "\x0d" (seq.++ "\xa0" (seq.++ "\x0d" (seq.++ "\xa0" (seq.++ "\x09" (seq.++ "'" (seq.++ "'" (seq.++ " " (seq.++ "\x0c" (seq.++ " " (seq.++ "\x09" (seq.++ ")" (seq.++ ")" (seq.++ "A" (seq.++ "N" (seq.++ "D" (seq.++ ":" (seq.++ "\x02" (seq.++ "\xc8" (seq.++ "\x96" ""))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (str.to_re (seq.++ "N" (seq.++ "O" (seq.++ "T" "")))))(re.++ (re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.* (re.range "(" "(")))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.range "=" "=")(re.union (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))))))(re.union (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" "")))))(re.union (str.to_re (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))(re.union (str.to_re (seq.++ "L" (seq.++ "I" (seq.++ "K" (seq.++ "E" ""))))) (str.to_re (seq.++ "I" (seq.++ "N" ""))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.++ (re.range "(" "(")(re.++ (re.* (re.union (re.range "\x00" "(") (re.range "*" "\xff"))) (re.range ")" ")")))(re.union (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\x00" "&") (re.range "(" "\xff"))) (re.range "'" "'"))) (re.++ (re.opt (re.range "-" "-"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) (re.+ (re.range "0" "9")))))))(re.++ (re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.* (re.range ")" ")")) (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))) (re.opt (re.union (str.to_re (seq.++ "A" (seq.++ "N" (seq.++ "D" "")))) (str.to_re (seq.++ "O" (seq.++ "R" ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
