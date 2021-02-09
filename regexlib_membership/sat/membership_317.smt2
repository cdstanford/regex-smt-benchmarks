;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \+353\(0\)\s\d\s\d{3}\s\d{4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "&+353(0)\u00858\u00A0857\u00859890lhF$\u00FF"
(define-fun Witness1 () String (seq.++ "&" (seq.++ "+" (seq.++ "3" (seq.++ "5" (seq.++ "3" (seq.++ "(" (seq.++ "0" (seq.++ ")" (seq.++ "\x85" (seq.++ "8" (seq.++ "\xa0" (seq.++ "8" (seq.++ "5" (seq.++ "7" (seq.++ "\x85" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "0" (seq.++ "l" (seq.++ "h" (seq.++ "F" (seq.++ "$" (seq.++ "\xff" "")))))))))))))))))))))))))
;witness2: "\u00A7+353(0)\xA5\u0085081\u00859989"
(define-fun Witness2 () String (seq.++ "\xa7" (seq.++ "+" (seq.++ "3" (seq.++ "5" (seq.++ "3" (seq.++ "(" (seq.++ "0" (seq.++ ")" (seq.++ "\x0a" (seq.++ "5" (seq.++ "\x85" (seq.++ "0" (seq.++ "8" (seq.++ "1" (seq.++ "\x85" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "9" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "+" (seq.++ "3" (seq.++ "5" (seq.++ "3" (seq.++ "(" (seq.++ "0" (seq.++ ")" ""))))))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) ((_ re.loop 4 4) (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
