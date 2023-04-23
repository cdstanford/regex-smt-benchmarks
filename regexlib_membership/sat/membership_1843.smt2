;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;[^&gt;]*name[\s]*=[\s]*&quot;?[^\w_]*&quot;?[^&gt;]*&gt;
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "&lt;name= &quot&quot;$nu\u00BD\u009E\u00F9&gt;"
(define-fun Witness1 () String (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" (str.++ "=" (str.++ " " (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "$" (str.++ "n" (str.++ "u" (str.++ "\u{bd}" (str.++ "\u{9e}" (str.++ "\u{f9}" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" ""))))))))))))))))))))))))))))))))
;witness2: "\u00D4ZR\u00DB\u008A\u00DB&lt;name=&quot\u00D7&quot\u00B0>\xB\u008F&gt;"
(define-fun Witness2 () String (str.++ "\u{d4}" (str.++ "Z" (str.++ "R" (str.++ "\u{db}" (str.++ "\u{8a}" (str.++ "\u{db}" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" (str.++ "=" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ "\u{d7}" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ "\u{b0}" (str.++ ">" (str.++ "\u{0b}" (str.++ "\u{8f}" (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" "")))))(re.++ (re.* (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\u{ff}"))))))(re.++ (str.to_re (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" "")))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" ""))))))(re.++ (re.opt (re.range ";" ";"))(re.++ (re.* (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}")))))))))))(re.++ (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" ""))))))(re.++ (re.opt (re.range ";" ";"))(re.++ (re.* (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\u{ff}")))))) (str.to_re (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
