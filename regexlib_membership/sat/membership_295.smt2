;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [\+]?[\s]?(\d(\-|\s)?)?(\(\d{3}\)\s?|\d{3}\-?)\d{3}(-|\s-\s)?\d{4}(\s(ex|ext)\s?\d+)?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+ 9(709)\u0085190-8988\u00A0ext 58\xF6"
(define-fun Witness1 () String (seq.++ "+" (seq.++ " " (seq.++ "9" (seq.++ "(" (seq.++ "7" (seq.++ "0" (seq.++ "9" (seq.++ ")" (seq.++ "\x85" (seq.++ "1" (seq.++ "9" (seq.++ "0" (seq.++ "-" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "\xa0" (seq.++ "e" (seq.++ "x" (seq.++ "t" (seq.++ " " (seq.++ "5" (seq.++ "8" (seq.++ "\x0f" (seq.++ "6" "")))))))))))))))))))))))))))
;witness2: "f\u00B6+\x946898940937="
(define-fun Witness2 () String (seq.++ "f" (seq.++ "\xb6" (seq.++ "+" (seq.++ "\x09" (seq.++ "4" (seq.++ "6" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "4" (seq.++ "0" (seq.++ "9" (seq.++ "3" (seq.++ "7" (seq.++ "=" "")))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.range "+" "+"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.++ (re.range "0" "9") (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))(re.++ (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range ")" ")") (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))) (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range "-" "-"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "-" "-") (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.range "-" "-") (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.opt (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.union (str.to_re (seq.++ "e" (seq.++ "x" ""))) (str.to_re (seq.++ "e" (seq.++ "x" (seq.++ "t" "")))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.+ (re.range "0" "9")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
