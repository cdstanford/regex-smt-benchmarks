;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;/?(\w+)(\s*\w*\s*=\s*(&quot;[^&quot;]*&quot;|'[^']'|[^&gt;]*))*|/?&gt;
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "W\u008F&lt;/8f M=\'\u00DD\'\xC\u00AA \xB="
(define-fun Witness1 () String (seq.++ "W" (seq.++ "\x8f" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "8" (seq.++ "f" (seq.++ " " (seq.++ "M" (seq.++ "=" (seq.++ "'" (seq.++ "\xdd" (seq.++ "'" (seq.++ "\x0c" (seq.++ "\xaa" (seq.++ " " (seq.++ "\x0b" (seq.++ "=" "")))))))))))))))))))))
;witness2: "\u0099\u00D1&lt;\u00AA_\u00BA=\u009Eh"
(define-fun Witness2 () String (seq.++ "\x99" (seq.++ "\xd1" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "\xaa" (seq.++ "_" (seq.++ "\xba" (seq.++ "=" (seq.++ "\x9e" (seq.++ "h" "")))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" "")))))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.* (re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union (re.++ (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))(re.++ (re.* (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\xff"))))))) (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))))(re.union (re.++ (re.range "'" "'")(re.++ (re.union (re.range "\x00" "&") (re.range "(" "\xff")) (re.range "'" "'"))) (re.* (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\xff"))))))))))))))))) (re.++ (re.opt (re.range "/" "/")) (str.to_re (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
