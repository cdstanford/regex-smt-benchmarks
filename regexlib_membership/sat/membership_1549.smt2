;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((([sS][r-tR-Tx-zX-Z])\s*([sx-zSX-Z])?\s*([a-zA-Z]{2,3}))?\s*(\d\d)\s*-?\s*(\d{6,7}))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\xD\xB\u008502-769932"
(define-fun Witness1 () String (seq.++ "\x0d" (seq.++ "\x0b" (seq.++ "\x85" (seq.++ "0" (seq.++ "2" (seq.++ "-" (seq.++ "7" (seq.++ "6" (seq.++ "9" (seq.++ "9" (seq.++ "3" (seq.++ "2" "")))))))))))))
;witness2: "SzsoJO\xD68\u00A0\u00A0795880"
(define-fun Witness2 () String (seq.++ "S" (seq.++ "z" (seq.++ "s" (seq.++ "o" (seq.++ "J" (seq.++ "O" (seq.++ "\x0d" (seq.++ "6" (seq.++ "8" (seq.++ "\xa0" (seq.++ "\xa0" (seq.++ "7" (seq.++ "9" (seq.++ "5" (seq.++ "8" (seq.++ "8" (seq.++ "0" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.++ (re.++ (re.union (re.range "S" "S") (re.range "s" "s")) (re.union (re.range "R" "T")(re.union (re.range "X" "Z")(re.union (re.range "r" "t") (re.range "x" "z")))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.union (re.range "S" "S")(re.union (re.range "X" "Z")(re.union (re.range "s" "s") (re.range "x" "z")))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 2 3) (re.union (re.range "A" "Z") (re.range "a" "z"))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.++ (re.range "0" "9") (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 6 7) (re.range "0" "9")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
