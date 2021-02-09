;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = 1?(?:[.\s-]?[2-9]\d{2}[.\s-]?|\s?\([2-9]\d{2}\)\s?)(?:[1-9]\d{2}[.\s-]?\d{4}\s?(?:\s?([xX]|[eE][xX]|[eE][xX]\.|[eE][xX][tT]|[eE][xX][tT]\.)\s?\d{3,4})?|[a-zA-Z]{7})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1\u0085858szDpKym"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "\x85" (seq.++ "8" (seq.++ "5" (seq.++ "8" (seq.++ "s" (seq.++ "z" (seq.++ "D" (seq.++ "p" (seq.++ "K" (seq.++ "y" (seq.++ "m" "")))))))))))))
;witness2: "\u00CDv588\xBTlZkTRQ"
(define-fun Witness2 () String (seq.++ "\xcd" (seq.++ "v" (seq.++ "5" (seq.++ "8" (seq.++ "8" (seq.++ "\x0b" (seq.++ "T" (seq.++ "l" (seq.++ "Z" (seq.++ "k" (seq.++ "T" (seq.++ "R" (seq.++ "Q" ""))))))))))))))

(assert (= regexA (re.++ (re.opt (re.range "1" "1"))(re.++ (re.union (re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))) (re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "(" "(")(re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range ")" ")") (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))))) (re.union (re.++ (re.range "1" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.opt (re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.union (re.range "X" "X") (re.range "x" "x"))(re.union (re.++ (re.union (re.range "E" "E") (re.range "e" "e")) (re.union (re.range "X" "X") (re.range "x" "x")))(re.union (re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.union (re.range "X" "X") (re.range "x" "x")) (re.range "." ".")))(re.union (re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.union (re.range "X" "X") (re.range "x" "x")) (re.union (re.range "T" "T") (re.range "t" "t")))) (re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.union (re.range "X" "X") (re.range "x" "x"))(re.++ (re.union (re.range "T" "T") (re.range "t" "t")) (re.range "." "."))))))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 3 4) (re.range "0" "9"))))))))))) ((_ re.loop 7 7) (re.union (re.range "A" "Z") (re.range "a" "z"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
