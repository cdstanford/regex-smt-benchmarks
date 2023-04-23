;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (< *balise[ *>|:(.|\n)*>| (.|\n)*>](.|\n)*</balise *>)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "<    balise|\u0090\u00EE</balise>"
(define-fun Witness1 () String (str.++ "<" (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ "b" (str.++ "a" (str.++ "l" (str.++ "i" (str.++ "s" (str.++ "e" (str.++ "|" (str.++ "\u{90}" (str.++ "\u{ee}" (str.++ "<" (str.++ "/" (str.++ "b" (str.++ "a" (str.++ "l" (str.++ "i" (str.++ "s" (str.++ "e" (str.++ ">" ""))))))))))))))))))))))))
;witness2: "< balise|u</balise  >"
(define-fun Witness2 () String (str.++ "<" (str.++ " " (str.++ "b" (str.++ "a" (str.++ "l" (str.++ "i" (str.++ "s" (str.++ "e" (str.++ "|" (str.++ "u" (str.++ "<" (str.++ "/" (str.++ "b" (str.++ "a" (str.++ "l" (str.++ "i" (str.++ "s" (str.++ "e" (str.++ " " (str.++ " " (str.++ ">" ""))))))))))))))))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.* (re.range " " " "))(re.++ (str.to_re (str.++ "b" (str.++ "a" (str.++ "l" (str.++ "i" (str.++ "s" (str.++ "e" "")))))))(re.++ (re.union (re.range "\u{0a}" "\u{0a}")(re.union (re.range " " " ")(re.union (re.range "(" "*")(re.union (re.range "." ".")(re.union (re.range ":" ":")(re.union (re.range ">" ">") (re.range "|" "|")))))))(re.++ (re.* (re.union (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (re.range "\u{0a}" "\u{0a}")))(re.++ (str.to_re (str.++ "<" (str.++ "/" (str.++ "b" (str.++ "a" (str.++ "l" (str.++ "i" (str.++ "s" (str.++ "e" "")))))))))(re.++ (re.* (re.range " " " ")) (re.range ">" ">"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
