;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:\+?1[ .*-]?)?(?:\(? ?)?\d{3}(?: ?\)?)? ?(?:\*|(?:\.|-){1,2})? ?\d{3} ?(?:\*|(?:\.|-){1,2})? ?\d{4} 
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(594  - 972 * 6368 \u00D3\u00D8ac"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "5" (seq.++ "9" (seq.++ "4" (seq.++ " " (seq.++ " " (seq.++ "-" (seq.++ " " (seq.++ "9" (seq.++ "7" (seq.++ "2" (seq.++ " " (seq.++ "*" (seq.++ " " (seq.++ "6" (seq.++ "3" (seq.++ "6" (seq.++ "8" (seq.++ " " (seq.++ "\xd3" (seq.++ "\xd8" (seq.++ "a" (seq.++ "c" ""))))))))))))))))))))))))
;witness2: "\u00DA?\u009A\x1A858922  5888 "
(define-fun Witness2 () String (seq.++ "\xda" (seq.++ "?" (seq.++ "\x9a" (seq.++ "\x1a" (seq.++ "8" (seq.++ "5" (seq.++ "8" (seq.++ "9" (seq.++ "2" (seq.++ "2" (seq.++ " " (seq.++ " " (seq.++ "5" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ " " ""))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.opt (re.range "+" "+"))(re.++ (re.range "1" "1") (re.opt (re.union (re.range " " " ")(re.union (re.range "*" "*") (re.range "-" ".")))))))(re.++ (re.opt (re.++ (re.opt (re.range "(" "(")) (re.opt (re.range " " " "))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.opt (re.range " " " ")) (re.opt (re.range ")" ")"))))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (re.union (re.range "*" "*") ((_ re.loop 1 2) (re.range "-" "."))))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (re.union (re.range "*" "*") ((_ re.loop 1 2) (re.range "-" "."))))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.range " " " ")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
