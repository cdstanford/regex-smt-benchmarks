;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (href=|url|import).*[\'"]([^(http:)].*css)[\'"]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00FEhref=\'\u009Acss\'"
(define-fun Witness1 () String (seq.++ "\xfe" (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "=" (seq.++ "'" (seq.++ "\x9a" (seq.++ "c" (seq.++ "s" (seq.++ "s" (seq.++ "'" "")))))))))))))
;witness2: "\x6\u0083l\u00DBurl\"ucss\'\u00A2"
(define-fun Witness2 () String (seq.++ "\x06" (seq.++ "\x83" (seq.++ "l" (seq.++ "\xdb" (seq.++ "u" (seq.++ "r" (seq.++ "l" (seq.++ "\x22" (seq.++ "u" (seq.++ "c" (seq.++ "s" (seq.++ "s" (seq.++ "'" (seq.++ "\xa2" "")))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "=" ""))))))(re.union (str.to_re (seq.++ "u" (seq.++ "r" (seq.++ "l" "")))) (str.to_re (seq.++ "i" (seq.++ "m" (seq.++ "p" (seq.++ "o" (seq.++ "r" (seq.++ "t" "")))))))))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.union (re.range "\x22" "\x22") (re.range "'" "'"))(re.++ (re.++ (re.union (re.range "\x00" "'")(re.union (re.range "*" "9")(re.union (re.range ";" "g")(re.union (re.range "i" "o")(re.union (re.range "q" "s") (re.range "u" "\xff"))))))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re (seq.++ "c" (seq.++ "s" (seq.++ "s" "")))))) (re.union (re.range "\x22" "\x22") (re.range "'" "'"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
