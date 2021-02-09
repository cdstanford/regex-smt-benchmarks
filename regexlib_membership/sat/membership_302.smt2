;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(b|B)(f|F)(p|P)(o|O)(\s|\sC/O\s)[0-9]{1,4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "bfpO\u00858\xA"
(define-fun Witness1 () String (seq.++ "b" (seq.++ "f" (seq.++ "p" (seq.++ "O" (seq.++ "\x85" (seq.++ "8" (seq.++ "\x0a" ""))))))))
;witness2: "BFpo 9^"
(define-fun Witness2 () String (seq.++ "B" (seq.++ "F" (seq.++ "p" (seq.++ "o" (seq.++ " " (seq.++ "9" (seq.++ "^" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "B" "B") (re.range "b" "b"))(re.++ (re.union (re.range "F" "F") (re.range "f" "f"))(re.++ (re.union (re.range "P" "P") (re.range "p" "p"))(re.++ (re.union (re.range "O" "O") (re.range "o" "o"))(re.++ (re.union (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (str.to_re (seq.++ "C" (seq.++ "/" (seq.++ "O" "")))) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))) ((_ re.loop 1 4) (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
