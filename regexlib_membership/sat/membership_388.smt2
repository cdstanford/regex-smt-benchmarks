;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:\+?1[ .*-]?)?(?:\(? ?)?\d{3}(?: ?\)?)? ?(?:\*|(?:\.|-){1,2})? ?\d{3} ?(?:\*|(?:\.|-){1,2})? ?\d{4} 
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(594  - 972 * 6368 \u00D3\u00D8ac"
(define-fun Witness1 () String (str.++ "(" (str.++ "5" (str.++ "9" (str.++ "4" (str.++ " " (str.++ " " (str.++ "-" (str.++ " " (str.++ "9" (str.++ "7" (str.++ "2" (str.++ " " (str.++ "*" (str.++ " " (str.++ "6" (str.++ "3" (str.++ "6" (str.++ "8" (str.++ " " (str.++ "\u{d3}" (str.++ "\u{d8}" (str.++ "a" (str.++ "c" ""))))))))))))))))))))))))
;witness2: "\u00DA?\u009A\x1A858922  5888 "
(define-fun Witness2 () String (str.++ "\u{da}" (str.++ "?" (str.++ "\u{9a}" (str.++ "\u{1a}" (str.++ "8" (str.++ "5" (str.++ "8" (str.++ "9" (str.++ "2" (str.++ "2" (str.++ " " (str.++ " " (str.++ "5" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ " " ""))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.opt (re.range "+" "+"))(re.++ (re.range "1" "1") (re.opt (re.union (re.range " " " ")(re.union (re.range "*" "*") (re.range "-" ".")))))))(re.++ (re.opt (re.++ (re.opt (re.range "(" "(")) (re.opt (re.range " " " "))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.opt (re.range " " " ")) (re.opt (re.range ")" ")"))))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (re.union (re.range "*" "*") ((_ re.loop 1 2) (re.range "-" "."))))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (re.union (re.range "*" "*") ((_ re.loop 1 2) (re.range "-" "."))))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.range " " " ")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
