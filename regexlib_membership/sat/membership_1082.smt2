;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:[\w]*) *= *"(?:(?:(?:(?:(?:\\\W)*\\\W)*[^"]*)\\\W)*[^"]*")
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "]\u00C5=\"\@\:\@\@\%\\x4\\u00D7\@\$\".)\u00E7"
(define-fun Witness1 () String (str.++ "]" (str.++ "\u{c5}" (str.++ "=" (str.++ "\u{22}" (str.++ "\u{5c}" (str.++ "@" (str.++ "\u{5c}" (str.++ ":" (str.++ "\u{5c}" (str.++ "@" (str.++ "\u{5c}" (str.++ "@" (str.++ "\u{5c}" (str.++ "%" (str.++ "\u{5c}" (str.++ "\u{04}" (str.++ "\u{5c}" (str.++ "\u{d7}" (str.++ "\u{5c}" (str.++ "@" (str.++ "\u{5c}" (str.++ "$" (str.++ "\u{22}" (str.++ "." (str.++ ")" (str.++ "\u{e7}" "")))))))))))))))))))))))))))
;witness2: "8 =\"\\u00F7\u00AAX\=A^\\u00D7\\xD\\u00AB\\u00BB\`\\u00A5\\u00F7\\u00D7\\x3\\u00D7\\u0096\u00F5\u0093\\u00F77\"\x15\u00E6G"
(define-fun Witness2 () String (str.++ "8" (str.++ " " (str.++ "=" (str.++ "\u{22}" (str.++ "\u{5c}" (str.++ "\u{f7}" (str.++ "\u{aa}" (str.++ "X" (str.++ "\u{5c}" (str.++ "=" (str.++ "A" (str.++ "^" (str.++ "\u{5c}" (str.++ "\u{d7}" (str.++ "\u{5c}" (str.++ "\u{0d}" (str.++ "\u{5c}" (str.++ "\u{ab}" (str.++ "\u{5c}" (str.++ "\u{bb}" (str.++ "\u{5c}" (str.++ "`" (str.++ "\u{5c}" (str.++ "\u{a5}" (str.++ "\u{5c}" (str.++ "\u{f7}" (str.++ "\u{5c}" (str.++ "\u{d7}" (str.++ "\u{5c}" (str.++ "\u{03}" (str.++ "\u{5c}" (str.++ "\u{d7}" (str.++ "\u{5c}" (str.++ "\u{96}" (str.++ "\u{f5}" (str.++ "\u{93}" (str.++ "\u{5c}" (str.++ "\u{f7}" (str.++ "7" (str.++ "\u{22}" (str.++ "\u{15}" (str.++ "\u{e6}" (str.++ "G" ""))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.* (re.range " " " "))(re.++ (re.range "=" "=")(re.++ (re.* (re.range " " " "))(re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.++ (re.* (re.++ (re.* (re.++ (re.range "\u{5c}" "\u{5c}") (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}"))))))))))))(re.++ (re.range "\u{5c}" "\u{5c}") (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}")))))))))))))(re.++ (re.* (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}")))(re.++ (re.range "\u{5c}" "\u{5c}") (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}"))))))))))))))(re.++ (re.* (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}"))) (re.range "\u{22}" "\u{22}"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
