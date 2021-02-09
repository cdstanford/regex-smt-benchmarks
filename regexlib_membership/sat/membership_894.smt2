;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\s+|)((\(\d{3}\) +)|(\d{3}-)|(\d{3} +))?\d{3}(-| +)\d{4}( +x\d{1,4})?(\s+|)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(868) 879 8981"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "8" (seq.++ "6" (seq.++ "8" (seq.++ ")" (seq.++ " " (seq.++ "8" (seq.++ "7" (seq.++ "9" (seq.++ " " (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "1" "")))))))))))))))
;witness2: "\u00CE531-998-8960 \u00FA"
(define-fun Witness2 () String (seq.++ "\xce" (seq.++ "5" (seq.++ "3" (seq.++ "1" (seq.++ "-" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "-" (seq.++ "8" (seq.++ "9" (seq.++ "6" (seq.++ "0" (seq.++ " " (seq.++ "\xfa" ""))))))))))))))))

(assert (= regexA (re.++ (re.union (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re ""))(re.++ (re.opt (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range ")" ")") (re.+ (re.range " " " ")))))(re.union (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range "-" "-")) (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.+ (re.range " " " "))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "-" "-") (re.+ (re.range " " " ")))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.+ (re.range " " " "))(re.++ (re.range "x" "x") ((_ re.loop 1 4) (re.range "0" "9"))))) (re.union (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
