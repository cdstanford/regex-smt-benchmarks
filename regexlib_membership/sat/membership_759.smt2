;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?i:t(?:ue(?:sday)?|hu(?:rsday)?))|s(?:un(?:day)?|at(?:urday)?)|(?:wed(?:nesday)?|(?:mon|fri)(?:day)?)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00D0\u00ED\u00B8sat"
(define-fun Witness1 () String (seq.++ "\xd0" (seq.++ "\xed" (seq.++ "\xb8" (seq.++ "s" (seq.++ "a" (seq.++ "t" "")))))))
;witness2: "friday\u00DE\x1B"
(define-fun Witness2 () String (seq.++ "f" (seq.++ "r" (seq.++ "i" (seq.++ "d" (seq.++ "a" (seq.++ "y" (seq.++ "\xde" (seq.++ "\x1b" "")))))))))

(assert (= regexA (re.union (re.++ (re.range "t" "t") (re.union (re.++ (str.to_re (seq.++ "u" (seq.++ "e" ""))) (re.opt (str.to_re (seq.++ "s" (seq.++ "d" (seq.++ "a" (seq.++ "y" ""))))))) (re.++ (str.to_re (seq.++ "h" (seq.++ "u" ""))) (re.opt (str.to_re (seq.++ "r" (seq.++ "s" (seq.++ "d" (seq.++ "a" (seq.++ "y" ""))))))))))(re.union (re.++ (re.range "s" "s") (re.union (re.++ (str.to_re (seq.++ "u" (seq.++ "n" ""))) (re.opt (str.to_re (seq.++ "d" (seq.++ "a" (seq.++ "y" "")))))) (re.++ (str.to_re (seq.++ "a" (seq.++ "t" ""))) (re.opt (str.to_re (seq.++ "u" (seq.++ "r" (seq.++ "d" (seq.++ "a" (seq.++ "y" ""))))))))))(re.union (re.++ (str.to_re (seq.++ "w" (seq.++ "e" (seq.++ "d" "")))) (re.opt (str.to_re (seq.++ "n" (seq.++ "e" (seq.++ "s" (seq.++ "d" (seq.++ "a" (seq.++ "y" ""))))))))) (re.++ (re.union (str.to_re (seq.++ "m" (seq.++ "o" (seq.++ "n" "")))) (str.to_re (seq.++ "f" (seq.++ "r" (seq.++ "i" ""))))) (re.opt (str.to_re (seq.++ "d" (seq.++ "a" (seq.++ "y" "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
