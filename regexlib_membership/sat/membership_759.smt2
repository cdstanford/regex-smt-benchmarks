;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?i:t(?:ue(?:sday)?|hu(?:rsday)?))|s(?:un(?:day)?|at(?:urday)?)|(?:wed(?:nesday)?|(?:mon|fri)(?:day)?)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00D0\u00ED\u00B8sat"
(define-fun Witness1 () String (str.++ "\u{d0}" (str.++ "\u{ed}" (str.++ "\u{b8}" (str.++ "s" (str.++ "a" (str.++ "t" "")))))))
;witness2: "friday\u00DE\x1B"
(define-fun Witness2 () String (str.++ "f" (str.++ "r" (str.++ "i" (str.++ "d" (str.++ "a" (str.++ "y" (str.++ "\u{de}" (str.++ "\u{1b}" "")))))))))

(assert (= regexA (re.union (re.++ (re.range "t" "t") (re.union (re.++ (str.to_re (str.++ "u" (str.++ "e" ""))) (re.opt (str.to_re (str.++ "s" (str.++ "d" (str.++ "a" (str.++ "y" ""))))))) (re.++ (str.to_re (str.++ "h" (str.++ "u" ""))) (re.opt (str.to_re (str.++ "r" (str.++ "s" (str.++ "d" (str.++ "a" (str.++ "y" ""))))))))))(re.union (re.++ (re.range "s" "s") (re.union (re.++ (str.to_re (str.++ "u" (str.++ "n" ""))) (re.opt (str.to_re (str.++ "d" (str.++ "a" (str.++ "y" "")))))) (re.++ (str.to_re (str.++ "a" (str.++ "t" ""))) (re.opt (str.to_re (str.++ "u" (str.++ "r" (str.++ "d" (str.++ "a" (str.++ "y" ""))))))))))(re.union (re.++ (str.to_re (str.++ "w" (str.++ "e" (str.++ "d" "")))) (re.opt (str.to_re (str.++ "n" (str.++ "e" (str.++ "s" (str.++ "d" (str.++ "a" (str.++ "y" ""))))))))) (re.++ (re.union (str.to_re (str.++ "m" (str.++ "o" (str.++ "n" "")))) (str.to_re (str.++ "f" (str.++ "r" (str.++ "i" ""))))) (re.opt (str.to_re (str.++ "d" (str.++ "a" (str.++ "y" "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
