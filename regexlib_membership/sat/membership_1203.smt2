;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((Fred|Wilma)\s+Flintstone|(Barney|Betty)\s+Rubble)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Wilma\u0085\u0085\u00A0Flintstone"
(define-fun Witness1 () String (seq.++ "W" (seq.++ "i" (seq.++ "l" (seq.++ "m" (seq.++ "a" (seq.++ "\x85" (seq.++ "\x85" (seq.++ "\xa0" (seq.++ "F" (seq.++ "l" (seq.++ "i" (seq.++ "n" (seq.++ "t" (seq.++ "s" (seq.++ "t" (seq.++ "o" (seq.++ "n" (seq.++ "e" "")))))))))))))))))))
;witness2: "Fred\xBFlintstone"
(define-fun Witness2 () String (seq.++ "F" (seq.++ "r" (seq.++ "e" (seq.++ "d" (seq.++ "\x0b" (seq.++ "F" (seq.++ "l" (seq.++ "i" (seq.++ "n" (seq.++ "t" (seq.++ "s" (seq.++ "t" (seq.++ "o" (seq.++ "n" (seq.++ "e" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (str.to_re (seq.++ "F" (seq.++ "r" (seq.++ "e" (seq.++ "d" ""))))) (str.to_re (seq.++ "W" (seq.++ "i" (seq.++ "l" (seq.++ "m" (seq.++ "a" "")))))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re (seq.++ "F" (seq.++ "l" (seq.++ "i" (seq.++ "n" (seq.++ "t" (seq.++ "s" (seq.++ "t" (seq.++ "o" (seq.++ "n" (seq.++ "e" ""))))))))))))) (re.++ (re.union (str.to_re (seq.++ "B" (seq.++ "a" (seq.++ "r" (seq.++ "n" (seq.++ "e" (seq.++ "y" ""))))))) (str.to_re (seq.++ "B" (seq.++ "e" (seq.++ "t" (seq.++ "t" (seq.++ "y" "")))))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re (seq.++ "R" (seq.++ "u" (seq.++ "b" (seq.++ "b" (seq.++ "l" (seq.++ "e" "")))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
