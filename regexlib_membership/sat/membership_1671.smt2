;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{2}\s{1}(Jan|Feb|Mar|Apr|May|Jun|Jul|Apr|Sep|Oct|Nov|Dec)\s{1}\d{4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "47\u0085Mar\x99210"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "7" (seq.++ "\x85" (seq.++ "M" (seq.++ "a" (seq.++ "r" (seq.++ "\x09" (seq.++ "9" (seq.++ "2" (seq.++ "1" (seq.++ "0" ""))))))))))))
;witness2: "58\u0085Nov 2908"
(define-fun Witness2 () String (seq.++ "5" (seq.++ "8" (seq.++ "\x85" (seq.++ "N" (seq.++ "o" (seq.++ "v" (seq.++ " " (seq.++ "2" (seq.++ "9" (seq.++ "0" (seq.++ "8" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.union (str.to_re (seq.++ "J" (seq.++ "a" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "F" (seq.++ "e" (seq.++ "b" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "a" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "p" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "a" (seq.++ "y" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "u" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "u" (seq.++ "l" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "p" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "S" (seq.++ "e" (seq.++ "p" ""))))(re.union (str.to_re (seq.++ "O" (seq.++ "c" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "N" (seq.++ "o" (seq.++ "v" "")))) (str.to_re (seq.++ "D" (seq.++ "e" (seq.++ "c" "")))))))))))))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
