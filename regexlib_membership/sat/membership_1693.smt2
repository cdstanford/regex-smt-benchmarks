;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\s*\(?0\d{4}\)?\s*\d{6}\s*)|(\s*\(?0\d{3}\)?\s*\d{3}\s*\d{4}\s*)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00EE06688)\x9828988\xD"
(define-fun Witness1 () String (seq.++ "\xee" (seq.++ "0" (seq.++ "6" (seq.++ "6" (seq.++ "8" (seq.++ "8" (seq.++ ")" (seq.++ "\x09" (seq.++ "8" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "\x0d" ""))))))))))))))))
;witness2: "\u00AB#|\u0085(0989\u0085889\u00A02399\xD\u00B7\u00F0F\xA"
(define-fun Witness2 () String (seq.++ "\xab" (seq.++ "#" (seq.++ "|" (seq.++ "\x85" (seq.++ "(" (seq.++ "0" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "\x85" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "\xa0" (seq.++ "2" (seq.++ "3" (seq.++ "9" (seq.++ "9" (seq.++ "\x0d" (seq.++ "\xb7" (seq.++ "\xf0" (seq.++ "F" (seq.++ "\x0a" ""))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))))) (re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
