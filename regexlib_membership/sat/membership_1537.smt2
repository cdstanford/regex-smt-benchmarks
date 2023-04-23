;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?i:on(blur|c(hange|lick)|dblclick|focus|keypress|(key|mouse)(down|up)|(un)?load|mouse(move|o(ut|ver))|reset|s(elect|ubmit)))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00A6\u00CA]oNrESET"
(define-fun Witness1 () String (str.++ "\u{a6}" (str.++ "\u{ca}" (str.++ "]" (str.++ "o" (str.++ "N" (str.++ "r" (str.++ "E" (str.++ "S" (str.++ "E" (str.++ "T" "")))))))))))
;witness2: "I`OnFoCUs\u00C5"
(define-fun Witness2 () String (str.++ "I" (str.++ "`" (str.++ "O" (str.++ "n" (str.++ "F" (str.++ "o" (str.++ "C" (str.++ "U" (str.++ "s" (str.++ "\u{c5}" "")))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "o" (str.++ "n" ""))) (re.union (str.to_re (str.++ "b" (str.++ "l" (str.++ "u" (str.++ "r" "")))))(re.union (re.++ (re.range "c" "c") (re.union (str.to_re (str.++ "h" (str.++ "a" (str.++ "n" (str.++ "g" (str.++ "e" "")))))) (str.to_re (str.++ "l" (str.++ "i" (str.++ "c" (str.++ "k" "")))))))(re.union (str.to_re (str.++ "d" (str.++ "b" (str.++ "l" (str.++ "c" (str.++ "l" (str.++ "i" (str.++ "c" (str.++ "k" "")))))))))(re.union (str.to_re (str.++ "f" (str.++ "o" (str.++ "c" (str.++ "u" (str.++ "s" ""))))))(re.union (str.to_re (str.++ "k" (str.++ "e" (str.++ "y" (str.++ "p" (str.++ "r" (str.++ "e" (str.++ "s" (str.++ "s" "")))))))))(re.union (re.++ (re.union (str.to_re (str.++ "k" (str.++ "e" (str.++ "y" "")))) (str.to_re (str.++ "m" (str.++ "o" (str.++ "u" (str.++ "s" (str.++ "e" ""))))))) (re.union (str.to_re (str.++ "d" (str.++ "o" (str.++ "w" (str.++ "n" ""))))) (str.to_re (str.++ "u" (str.++ "p" "")))))(re.union (re.++ (re.opt (str.to_re (str.++ "u" (str.++ "n" "")))) (str.to_re (str.++ "l" (str.++ "o" (str.++ "a" (str.++ "d" ""))))))(re.union (re.++ (str.to_re (str.++ "m" (str.++ "o" (str.++ "u" (str.++ "s" (str.++ "e" "")))))) (re.union (str.to_re (str.++ "m" (str.++ "o" (str.++ "v" (str.++ "e" ""))))) (re.++ (re.range "o" "o") (re.union (str.to_re (str.++ "u" (str.++ "t" ""))) (str.to_re (str.++ "v" (str.++ "e" (str.++ "r" ""))))))))(re.union (str.to_re (str.++ "r" (str.++ "e" (str.++ "s" (str.++ "e" (str.++ "t" "")))))) (re.++ (re.range "s" "s") (re.union (str.to_re (str.++ "e" (str.++ "l" (str.++ "e" (str.++ "c" (str.++ "t" "")))))) (str.to_re (str.++ "u" (str.++ "b" (str.++ "m" (str.++ "i" (str.++ "t" ""))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
