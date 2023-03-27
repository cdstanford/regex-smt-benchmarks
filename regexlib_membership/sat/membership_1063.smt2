;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w ]*.*))+\.((html|HTML)|(htm|HTM))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\\\u00C6$\\u00EE\u00C68.HTML"
(define-fun Witness1 () String (str.++ "\u{5c}" (str.++ "\u{5c}" (str.++ "\u{c6}" (str.++ "$" (str.++ "\u{5c}" (str.++ "\u{ee}" (str.++ "\u{c6}" (str.++ "8" (str.++ "." (str.++ "H" (str.++ "T" (str.++ "M" (str.++ "L" ""))))))))))))))
;witness2: "R:\\u00AAv\\u00AA.HTML"
(define-fun Witness2 () String (str.++ "R" (str.++ ":" (str.++ "\u{5c}" (str.++ "\u{aa}" (str.++ "v" (str.++ "\u{5c}" (str.++ "\u{aa}" (str.++ "." (str.++ "H" (str.++ "T" (str.++ "M" (str.++ "L" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range ":" ":")) (re.++ (re.++ ((_ re.loop 2 2) (re.range "\u{5c}" "\u{5c}")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (re.opt (re.range "$" "$"))))(re.++ (re.+ (re.++ (re.range "\u{5c}" "\u{5c}") (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))))))(re.++ (re.range "." ".")(re.++ (re.union (re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "m" (str.++ "l" ""))))) (str.to_re (str.++ "H" (str.++ "T" (str.++ "M" (str.++ "L" "")))))) (re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "m" "")))) (str.to_re (str.++ "H" (str.++ "T" (str.++ "M" "")))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
