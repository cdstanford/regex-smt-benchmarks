;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \w?<\s?\/?[^\s>]+(\s+[^"'=]+(=("[^"]*")|('[^\']*')|([^\s"'>]*))?)*\s*\/?>
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "8<\u0091\u00A1\u00A0G \u0085 >P"
(define-fun Witness1 () String (str.++ "8" (str.++ "<" (str.++ "\u{91}" (str.++ "\u{a1}" (str.++ "\u{a0}" (str.++ "G" (str.++ " " (str.++ "\u{85}" (str.++ " " (str.++ ">" (str.++ "P" ""))))))))))))
;witness2: "\u00B5<\u0085\x4/>q"
(define-fun Witness2 () String (str.++ "\u{b5}" (str.++ "<" (str.++ "\u{85}" (str.++ "\u{04}" (str.++ "/" (str.++ ">" (str.++ "q" ""))))))))

(assert (= regexA (re.++ (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range "<" "<")(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "=")(re.union (re.range "?" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))))(re.++ (re.* (re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "\u{00}" "!")(re.union (re.range "#" "&")(re.union (re.range "(" "<") (re.range ">" "\u{ff}"))))) (re.opt (re.union (re.++ (re.range "=" "=") (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}"))) (re.range "\u{22}" "\u{22}"))))(re.union (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\u{00}" "&") (re.range "(" "\u{ff}"))) (re.range "'" "'"))) (re.* (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "!")(re.union (re.range "#" "&")(re.union (re.range "(" "=")(re.union (re.range "?" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "/" "/")) (re.range ">" ">")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
