;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;/?(\w+)(\s*\w*\s*=\s*(&quot;[^&quot;]*&quot;|'[^']'|[^&gt;]*))*|/?&gt;
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "W\u008F&lt;/8f M=\'\u00DD\'\xC\u00AA \xB="
(define-fun Witness1 () String (str.++ "W" (str.++ "\u{8f}" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "/" (str.++ "8" (str.++ "f" (str.++ " " (str.++ "M" (str.++ "=" (str.++ "'" (str.++ "\u{dd}" (str.++ "'" (str.++ "\u{0c}" (str.++ "\u{aa}" (str.++ " " (str.++ "\u{0b}" (str.++ "=" "")))))))))))))))))))))
;witness2: "\u0099\u00D1&lt;\u00AA_\u00BA=\u009Eh"
(define-fun Witness2 () String (str.++ "\u{99}" (str.++ "\u{d1}" (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" (str.++ "\u{aa}" (str.++ "_" (str.++ "\u{ba}" (str.++ "=" (str.++ "\u{9e}" (str.++ "h" "")))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (str.++ "&" (str.++ "l" (str.++ "t" (str.++ ";" "")))))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.* (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.union (re.++ (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" "")))))))(re.++ (re.* (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\u{ff}"))))))) (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" "")))))))))(re.union (re.++ (re.range "'" "'")(re.++ (re.union (re.range "\u{00}" "&") (re.range "(" "\u{ff}")) (re.range "'" "'"))) (re.* (re.union (re.range "\u{00}" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\u{ff}"))))))))))))))))) (re.++ (re.opt (re.range "/" "/")) (str.to_re (str.++ "&" (str.++ "g" (str.++ "t" (str.++ ";" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
