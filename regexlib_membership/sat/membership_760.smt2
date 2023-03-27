;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?i:(?:j(?:an(?:uary)?|u(?:ne?|ly?)))|a(?:pr(?:il)?|ug(?:ust)?)|ma(?:y|r(?:ch)?)|(?:nov|dec)(?:ember)?|feb(?:ruary)?|sep(?:tember)?|oct(?:ober)?)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "DEcEmBer"
(define-fun Witness1 () String (str.++ "D" (str.++ "E" (str.++ "c" (str.++ "E" (str.++ "m" (str.++ "B" (str.++ "e" (str.++ "r" "")))))))))
;witness2: "\u009D(\u00D9sEp\x1E\u007F\u00AC\u00F9"
(define-fun Witness2 () String (str.++ "\u{9d}" (str.++ "(" (str.++ "\u{d9}" (str.++ "s" (str.++ "E" (str.++ "p" (str.++ "\u{1e}" (str.++ "\u{7f}" (str.++ "\u{ac}" (str.++ "\u{f9}" "")))))))))))

(assert (= regexA (re.union (re.++ (re.range "j" "j") (re.union (re.++ (str.to_re (str.++ "a" (str.++ "n" ""))) (re.opt (str.to_re (str.++ "u" (str.++ "a" (str.++ "r" (str.++ "y" ""))))))) (re.++ (re.range "u" "u") (re.union (re.++ (re.range "n" "n") (re.opt (re.range "e" "e"))) (re.++ (re.range "l" "l") (re.opt (re.range "y" "y")))))))(re.union (re.++ (re.range "a" "a") (re.union (re.++ (str.to_re (str.++ "p" (str.++ "r" ""))) (re.opt (str.to_re (str.++ "i" (str.++ "l" ""))))) (re.++ (str.to_re (str.++ "u" (str.++ "g" ""))) (re.opt (str.to_re (str.++ "u" (str.++ "s" (str.++ "t" ""))))))))(re.union (re.++ (str.to_re (str.++ "m" (str.++ "a" ""))) (re.union (re.range "y" "y") (re.++ (re.range "r" "r") (re.opt (str.to_re (str.++ "c" (str.++ "h" "")))))))(re.union (re.++ (re.union (str.to_re (str.++ "n" (str.++ "o" (str.++ "v" "")))) (str.to_re (str.++ "d" (str.++ "e" (str.++ "c" ""))))) (re.opt (str.to_re (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" ""))))))))(re.union (re.++ (str.to_re (str.++ "f" (str.++ "e" (str.++ "b" "")))) (re.opt (str.to_re (str.++ "r" (str.++ "u" (str.++ "a" (str.++ "r" (str.++ "y" ""))))))))(re.union (re.++ (str.to_re (str.++ "s" (str.++ "e" (str.++ "p" "")))) (re.opt (str.to_re (str.++ "t" (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" ""))))))))) (re.++ (str.to_re (str.++ "o" (str.++ "c" (str.++ "t" "")))) (re.opt (str.to_re (str.++ "o" (str.++ "b" (str.++ "e" (str.++ "r" "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
