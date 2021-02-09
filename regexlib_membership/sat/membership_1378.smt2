;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = X-Spam-Level:\s[*]{11}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "X-Spam-Level:\u0085***********"
(define-fun Witness1 () String (seq.++ "X" (seq.++ "-" (seq.++ "S" (seq.++ "p" (seq.++ "a" (seq.++ "m" (seq.++ "-" (seq.++ "L" (seq.++ "e" (seq.++ "v" (seq.++ "e" (seq.++ "l" (seq.++ ":" (seq.++ "\x85" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "*" ""))))))))))))))))))))))))))
;witness2: "X-Spam-Level:\u0085***********\u00DCv"
(define-fun Witness2 () String (seq.++ "X" (seq.++ "-" (seq.++ "S" (seq.++ "p" (seq.++ "a" (seq.++ "m" (seq.++ "-" (seq.++ "L" (seq.++ "e" (seq.++ "v" (seq.++ "e" (seq.++ "l" (seq.++ ":" (seq.++ "\x85" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "*" (seq.++ "\xdc" (seq.++ "v" ""))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "X" (seq.++ "-" (seq.++ "S" (seq.++ "p" (seq.++ "a" (seq.++ "m" (seq.++ "-" (seq.++ "L" (seq.++ "e" (seq.++ "v" (seq.++ "e" (seq.++ "l" (seq.++ ":" ""))))))))))))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) ((_ re.loop 11 11) (re.range "*" "*"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
