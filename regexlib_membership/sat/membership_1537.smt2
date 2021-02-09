;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?i:on(blur|c(hange|lick)|dblclick|focus|keypress|(key|mouse)(down|up)|(un)?load|mouse(move|o(ut|ver))|reset|s(elect|ubmit)))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00A6\u00CA]oNrESET"
(define-fun Witness1 () String (seq.++ "\xa6" (seq.++ "\xca" (seq.++ "]" (seq.++ "o" (seq.++ "N" (seq.++ "r" (seq.++ "E" (seq.++ "S" (seq.++ "E" (seq.++ "T" "")))))))))))
;witness2: "I`OnFoCUs\u00C5"
(define-fun Witness2 () String (seq.++ "I" (seq.++ "`" (seq.++ "O" (seq.++ "n" (seq.++ "F" (seq.++ "o" (seq.++ "C" (seq.++ "U" (seq.++ "s" (seq.++ "\xc5" "")))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "o" (seq.++ "n" ""))) (re.union (str.to_re (seq.++ "b" (seq.++ "l" (seq.++ "u" (seq.++ "r" "")))))(re.union (re.++ (re.range "c" "c") (re.union (str.to_re (seq.++ "h" (seq.++ "a" (seq.++ "n" (seq.++ "g" (seq.++ "e" "")))))) (str.to_re (seq.++ "l" (seq.++ "i" (seq.++ "c" (seq.++ "k" "")))))))(re.union (str.to_re (seq.++ "d" (seq.++ "b" (seq.++ "l" (seq.++ "c" (seq.++ "l" (seq.++ "i" (seq.++ "c" (seq.++ "k" "")))))))))(re.union (str.to_re (seq.++ "f" (seq.++ "o" (seq.++ "c" (seq.++ "u" (seq.++ "s" ""))))))(re.union (str.to_re (seq.++ "k" (seq.++ "e" (seq.++ "y" (seq.++ "p" (seq.++ "r" (seq.++ "e" (seq.++ "s" (seq.++ "s" "")))))))))(re.union (re.++ (re.union (str.to_re (seq.++ "k" (seq.++ "e" (seq.++ "y" "")))) (str.to_re (seq.++ "m" (seq.++ "o" (seq.++ "u" (seq.++ "s" (seq.++ "e" ""))))))) (re.union (str.to_re (seq.++ "d" (seq.++ "o" (seq.++ "w" (seq.++ "n" ""))))) (str.to_re (seq.++ "u" (seq.++ "p" "")))))(re.union (re.++ (re.opt (str.to_re (seq.++ "u" (seq.++ "n" "")))) (str.to_re (seq.++ "l" (seq.++ "o" (seq.++ "a" (seq.++ "d" ""))))))(re.union (re.++ (str.to_re (seq.++ "m" (seq.++ "o" (seq.++ "u" (seq.++ "s" (seq.++ "e" "")))))) (re.union (str.to_re (seq.++ "m" (seq.++ "o" (seq.++ "v" (seq.++ "e" ""))))) (re.++ (re.range "o" "o") (re.union (str.to_re (seq.++ "u" (seq.++ "t" ""))) (str.to_re (seq.++ "v" (seq.++ "e" (seq.++ "r" ""))))))))(re.union (str.to_re (seq.++ "r" (seq.++ "e" (seq.++ "s" (seq.++ "e" (seq.++ "t" "")))))) (re.++ (re.range "s" "s") (re.union (str.to_re (seq.++ "e" (seq.++ "l" (seq.++ "e" (seq.++ "c" (seq.++ "t" "")))))) (str.to_re (seq.++ "u" (seq.++ "b" (seq.++ "m" (seq.++ "i" (seq.++ "t" ""))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
