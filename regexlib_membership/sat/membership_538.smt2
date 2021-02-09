;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\d{1,6}\-\d{1,6})|(\d{1,6}\\\d{1,6})|(\d{1,6})(\/)(\d{1,6})|(\w{1}\-?\d{1,6})|(\w{1}\s\d{1,6})|((P\.?O\.?\s)((BOX)|(Box))(\s\d{1,6}))|((([R]{2})|([H][C]))(\s\d{1,6}\s)((BOX)|(Box))(\s\d{1,6}))?)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "A-8"
(define-fun Witness1 () String (seq.++ "A" (seq.++ "-" (seq.++ "8" ""))))
;witness2: "\u00F95898"
(define-fun Witness2 () String (seq.++ "\xf9" (seq.++ "5" (seq.++ "8" (seq.++ "9" (seq.++ "8" ""))))))

(assert (= regexA (re.++ (re.union (re.++ ((_ re.loop 1 6) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 1 6) (re.range "0" "9"))))(re.union (re.++ ((_ re.loop 1 6) (re.range "0" "9"))(re.++ (re.range "\x5c" "\x5c") ((_ re.loop 1 6) (re.range "0" "9"))))(re.union (re.++ ((_ re.loop 1 6) (re.range "0" "9"))(re.++ (re.range "/" "/") ((_ re.loop 1 6) (re.range "0" "9"))))(re.union (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 1 6) (re.range "0" "9"))))(re.union (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) ((_ re.loop 1 6) (re.range "0" "9"))))(re.union (re.++ (re.++ (re.range "P" "P")(re.++ (re.opt (re.range "." "."))(re.++ (re.range "O" "O")(re.++ (re.opt (re.range "." ".")) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))(re.++ (re.union (str.to_re (seq.++ "B" (seq.++ "O" (seq.++ "X" "")))) (str.to_re (seq.++ "B" (seq.++ "o" (seq.++ "x" ""))))) (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) ((_ re.loop 1 6) (re.range "0" "9"))))) (re.opt (re.++ (re.union ((_ re.loop 2 2) (re.range "R" "R")) (str.to_re (seq.++ "H" (seq.++ "C" ""))))(re.++ (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ ((_ re.loop 1 6) (re.range "0" "9")) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ (re.union (str.to_re (seq.++ "B" (seq.++ "O" (seq.++ "X" "")))) (str.to_re (seq.++ "B" (seq.++ "o" (seq.++ "x" ""))))) (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) ((_ re.loop 1 6) (re.range "0" "9"))))))))))))) (str.to_re ""))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
