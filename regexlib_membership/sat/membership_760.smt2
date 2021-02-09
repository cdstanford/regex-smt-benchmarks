;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?i:(?:j(?:an(?:uary)?|u(?:ne?|ly?)))|a(?:pr(?:il)?|ug(?:ust)?)|ma(?:y|r(?:ch)?)|(?:nov|dec)(?:ember)?|feb(?:ruary)?|sep(?:tember)?|oct(?:ober)?)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "DEcEmBer"
(define-fun Witness1 () String (seq.++ "D" (seq.++ "E" (seq.++ "c" (seq.++ "E" (seq.++ "m" (seq.++ "B" (seq.++ "e" (seq.++ "r" "")))))))))
;witness2: "\u009D(\u00D9sEp\x1E\u007F\u00AC\u00F9"
(define-fun Witness2 () String (seq.++ "\x9d" (seq.++ "(" (seq.++ "\xd9" (seq.++ "s" (seq.++ "E" (seq.++ "p" (seq.++ "\x1e" (seq.++ "\x7f" (seq.++ "\xac" (seq.++ "\xf9" "")))))))))))

(assert (= regexA (re.union (re.++ (re.range "j" "j") (re.union (re.++ (str.to_re (seq.++ "a" (seq.++ "n" ""))) (re.opt (str.to_re (seq.++ "u" (seq.++ "a" (seq.++ "r" (seq.++ "y" ""))))))) (re.++ (re.range "u" "u") (re.union (re.++ (re.range "n" "n") (re.opt (re.range "e" "e"))) (re.++ (re.range "l" "l") (re.opt (re.range "y" "y")))))))(re.union (re.++ (re.range "a" "a") (re.union (re.++ (str.to_re (seq.++ "p" (seq.++ "r" ""))) (re.opt (str.to_re (seq.++ "i" (seq.++ "l" ""))))) (re.++ (str.to_re (seq.++ "u" (seq.++ "g" ""))) (re.opt (str.to_re (seq.++ "u" (seq.++ "s" (seq.++ "t" ""))))))))(re.union (re.++ (str.to_re (seq.++ "m" (seq.++ "a" ""))) (re.union (re.range "y" "y") (re.++ (re.range "r" "r") (re.opt (str.to_re (seq.++ "c" (seq.++ "h" "")))))))(re.union (re.++ (re.union (str.to_re (seq.++ "n" (seq.++ "o" (seq.++ "v" "")))) (str.to_re (seq.++ "d" (seq.++ "e" (seq.++ "c" ""))))) (re.opt (str.to_re (seq.++ "e" (seq.++ "m" (seq.++ "b" (seq.++ "e" (seq.++ "r" ""))))))))(re.union (re.++ (str.to_re (seq.++ "f" (seq.++ "e" (seq.++ "b" "")))) (re.opt (str.to_re (seq.++ "r" (seq.++ "u" (seq.++ "a" (seq.++ "r" (seq.++ "y" ""))))))))(re.union (re.++ (str.to_re (seq.++ "s" (seq.++ "e" (seq.++ "p" "")))) (re.opt (str.to_re (seq.++ "t" (seq.++ "e" (seq.++ "m" (seq.++ "b" (seq.++ "e" (seq.++ "r" ""))))))))) (re.++ (str.to_re (seq.++ "o" (seq.++ "c" (seq.++ "t" "")))) (re.opt (str.to_re (seq.++ "o" (seq.++ "b" (seq.++ "e" (seq.++ "r" "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
