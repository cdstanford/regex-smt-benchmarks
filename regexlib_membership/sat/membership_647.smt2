;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(Op(.|us))(\s)[1-9](\d)*((,)?(\s)N(o.|um(.|ber))\s[1-9](\d)*)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Op,\xB8,\x9No8\u00858"
(define-fun Witness1 () String (seq.++ "O" (seq.++ "p" (seq.++ "," (seq.++ "\x0b" (seq.++ "8" (seq.++ "," (seq.++ "\x09" (seq.++ "N" (seq.++ "o" (seq.++ "8" (seq.++ "\x85" (seq.++ "8" "")))))))))))))
;witness2: "Opus\u008558"
(define-fun Witness2 () String (seq.++ "O" (seq.++ "p" (seq.++ "u" (seq.++ "s" (seq.++ "\x85" (seq.++ "5" (seq.++ "8" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (seq.++ "O" (seq.++ "p" ""))) (re.union (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "u" (seq.++ "s" "")))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.range "1" "9")(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.++ (re.opt (re.range "," ","))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.range "N" "N")(re.++ (re.union (re.++ (re.range "o" "o") (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.++ (str.to_re (seq.++ "u" (seq.++ "m" ""))) (re.union (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "b" (seq.++ "e" (seq.++ "r" "")))))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.range "1" "9") (re.* (re.range "0" "9"))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
