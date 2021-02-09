;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\\d{1}-\\d{2}\\s*)(of +)(\\s?\\d{5})|(\\d{1}-\\d{2}\\s*)(of +)(\\s?\\d{4})|(\\d{1}-\\d{2}\\s*)(of +)(\\s?\\d{3})|(\\d{1}-\\d{2}\\s*)(of +)(\\s?\\d{2})|(\\d{1}-\\d{2}\\s*)(of +)(\\s?\\d{1})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\d-\dd\of  \\d"
(define-fun Witness1 () String (seq.++ "\x5c" (seq.++ "d" (seq.++ "-" (seq.++ "\x5c" (seq.++ "d" (seq.++ "d" (seq.++ "\x5c" (seq.++ "o" (seq.++ "f" (seq.++ " " (seq.++ " " (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "d" "")))))))))))))))
;witness2: "\d-\dd\of   \s\d"
(define-fun Witness2 () String (seq.++ "\x5c" (seq.++ "d" (seq.++ "-" (seq.++ "\x5c" (seq.++ "d" (seq.++ "d" (seq.++ "\x5c" (seq.++ "o" (seq.++ "f" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "\x5c" (seq.++ "s" (seq.++ "\x5c" (seq.++ "d" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (re.++ (str.to_re (seq.++ "\x5c" (seq.++ "d" (seq.++ "-" (seq.++ "\x5c" "")))))(re.++ ((_ re.loop 2 2) (re.range "d" "d"))(re.++ (re.range "\x5c" "\x5c") (re.* (re.range "s" "s")))))(re.++ (re.++ (str.to_re (seq.++ "o" (seq.++ "f" ""))) (re.+ (re.range " " " "))) (re.++ (re.range "\x5c" "\x5c")(re.++ (re.opt (re.range "s" "s"))(re.++ (re.range "\x5c" "\x5c") ((_ re.loop 5 5) (re.range "d" "d")))))))(re.union (re.++ (re.++ (str.to_re (seq.++ "\x5c" (seq.++ "d" (seq.++ "-" (seq.++ "\x5c" "")))))(re.++ ((_ re.loop 2 2) (re.range "d" "d"))(re.++ (re.range "\x5c" "\x5c") (re.* (re.range "s" "s")))))(re.++ (re.++ (str.to_re (seq.++ "o" (seq.++ "f" ""))) (re.+ (re.range " " " "))) (re.++ (re.range "\x5c" "\x5c")(re.++ (re.opt (re.range "s" "s"))(re.++ (re.range "\x5c" "\x5c") ((_ re.loop 4 4) (re.range "d" "d")))))))(re.union (re.++ (re.++ (str.to_re (seq.++ "\x5c" (seq.++ "d" (seq.++ "-" (seq.++ "\x5c" "")))))(re.++ ((_ re.loop 2 2) (re.range "d" "d"))(re.++ (re.range "\x5c" "\x5c") (re.* (re.range "s" "s")))))(re.++ (re.++ (str.to_re (seq.++ "o" (seq.++ "f" ""))) (re.+ (re.range " " " "))) (re.++ (re.range "\x5c" "\x5c")(re.++ (re.opt (re.range "s" "s"))(re.++ (re.range "\x5c" "\x5c") ((_ re.loop 3 3) (re.range "d" "d")))))))(re.union (re.++ (re.++ (str.to_re (seq.++ "\x5c" (seq.++ "d" (seq.++ "-" (seq.++ "\x5c" "")))))(re.++ ((_ re.loop 2 2) (re.range "d" "d"))(re.++ (re.range "\x5c" "\x5c") (re.* (re.range "s" "s")))))(re.++ (re.++ (str.to_re (seq.++ "o" (seq.++ "f" ""))) (re.+ (re.range " " " "))) (re.++ (re.range "\x5c" "\x5c")(re.++ (re.opt (re.range "s" "s"))(re.++ (re.range "\x5c" "\x5c") ((_ re.loop 2 2) (re.range "d" "d"))))))) (re.++ (re.++ (str.to_re (seq.++ "\x5c" (seq.++ "d" (seq.++ "-" (seq.++ "\x5c" "")))))(re.++ ((_ re.loop 2 2) (re.range "d" "d"))(re.++ (re.range "\x5c" "\x5c") (re.* (re.range "s" "s")))))(re.++ (re.++ (str.to_re (seq.++ "o" (seq.++ "f" ""))) (re.+ (re.range " " " "))) (re.++ (re.range "\x5c" "\x5c")(re.++ (re.opt (re.range "s" "s")) (str.to_re (seq.++ "\x5c" (seq.++ "d" "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
