;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\s|\n|^)(\w+://[^\s\n]+)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00A0\u00FC://\u00EE\u00D4\u00AD"
(define-fun Witness1 () String (str.++ "\u{a0}" (str.++ "\u{fc}" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "\u{ee}" (str.++ "\u{d4}" (str.++ "\u{ad}" "")))))))))
;witness2: "\u0085\u00BA://H\u009Bg\u00D9\u00F1\u00A5"
(define-fun Witness2 () String (str.++ "\u{85}" (str.++ "\u{ba}" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "H" (str.++ "\u{9b}" (str.++ "g" (str.++ "\u{d9}" (str.++ "\u{f1}" (str.++ "\u{a5}" ""))))))))))))

(assert (= regexA (re.++ (re.union (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) (str.to_re "")) (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" "")))) (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
