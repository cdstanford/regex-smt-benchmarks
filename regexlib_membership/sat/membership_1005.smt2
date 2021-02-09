;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (< *balise[ *>|:(.|\n)*>| (.|\n)*>](.|\n)*</balise *>)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "<    balise|\u0090\u00EE</balise>"
(define-fun Witness1 () String (seq.++ "<" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "b" (seq.++ "a" (seq.++ "l" (seq.++ "i" (seq.++ "s" (seq.++ "e" (seq.++ "|" (seq.++ "\x90" (seq.++ "\xee" (seq.++ "<" (seq.++ "/" (seq.++ "b" (seq.++ "a" (seq.++ "l" (seq.++ "i" (seq.++ "s" (seq.++ "e" (seq.++ ">" ""))))))))))))))))))))))))
;witness2: "< balise|u</balise  >"
(define-fun Witness2 () String (seq.++ "<" (seq.++ " " (seq.++ "b" (seq.++ "a" (seq.++ "l" (seq.++ "i" (seq.++ "s" (seq.++ "e" (seq.++ "|" (seq.++ "u" (seq.++ "<" (seq.++ "/" (seq.++ "b" (seq.++ "a" (seq.++ "l" (seq.++ "i" (seq.++ "s" (seq.++ "e" (seq.++ " " (seq.++ " " (seq.++ ">" ""))))))))))))))))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.* (re.range " " " "))(re.++ (str.to_re (seq.++ "b" (seq.++ "a" (seq.++ "l" (seq.++ "i" (seq.++ "s" (seq.++ "e" "")))))))(re.++ (re.union (re.range "\x0a" "\x0a")(re.union (re.range " " " ")(re.union (re.range "(" "*")(re.union (re.range "." ".")(re.union (re.range ":" ":")(re.union (re.range ">" ">") (re.range "|" "|")))))))(re.++ (re.* (re.union (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (re.range "\x0a" "\x0a")))(re.++ (str.to_re (seq.++ "<" (seq.++ "/" (seq.++ "b" (seq.++ "a" (seq.++ "l" (seq.++ "i" (seq.++ "s" (seq.++ "e" "")))))))))(re.++ (re.* (re.range " " " ")) (re.range ">" ">"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
