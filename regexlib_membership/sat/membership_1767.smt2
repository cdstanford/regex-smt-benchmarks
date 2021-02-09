;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(ac|AC|al|AL|am|AM|ap|AP|ba|BA|ce|CE|df|DF|es|ES|go|GO|ma|MA|mg|MG|ms|MS|mt|MT|pa|PA|pb|PB|pe|PE|pi|PI|pr|PR|rj|RJ|rn|RN|ro|RO|rr|RR|rs|RS|sc|SC|se|SE|sp|SP|to|TO)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "SP"
(define-fun Witness1 () String (seq.++ "S" (seq.++ "P" "")))
;witness2: "RO"
(define-fun Witness2 () String (seq.++ "R" (seq.++ "O" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (seq.++ "a" (seq.++ "c" "")))(re.union (str.to_re (seq.++ "A" (seq.++ "C" "")))(re.union (str.to_re (seq.++ "a" (seq.++ "l" "")))(re.union (str.to_re (seq.++ "A" (seq.++ "L" "")))(re.union (str.to_re (seq.++ "a" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "A" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "a" (seq.++ "p" "")))(re.union (str.to_re (seq.++ "A" (seq.++ "P" "")))(re.union (str.to_re (seq.++ "b" (seq.++ "a" "")))(re.union (str.to_re (seq.++ "B" (seq.++ "A" "")))(re.union (str.to_re (seq.++ "c" (seq.++ "e" "")))(re.union (str.to_re (seq.++ "C" (seq.++ "E" "")))(re.union (str.to_re (seq.++ "d" (seq.++ "f" "")))(re.union (str.to_re (seq.++ "D" (seq.++ "F" "")))(re.union (str.to_re (seq.++ "e" (seq.++ "s" "")))(re.union (str.to_re (seq.++ "E" (seq.++ "S" "")))(re.union (str.to_re (seq.++ "g" (seq.++ "o" "")))(re.union (str.to_re (seq.++ "G" (seq.++ "O" "")))(re.union (str.to_re (seq.++ "m" (seq.++ "a" "")))(re.union (str.to_re (seq.++ "M" (seq.++ "A" "")))(re.union (str.to_re (seq.++ "m" (seq.++ "g" "")))(re.union (str.to_re (seq.++ "M" (seq.++ "G" "")))(re.union (str.to_re (seq.++ "m" (seq.++ "s" "")))(re.union (str.to_re (seq.++ "M" (seq.++ "S" "")))(re.union (str.to_re (seq.++ "m" (seq.++ "t" "")))(re.union (str.to_re (seq.++ "M" (seq.++ "T" "")))(re.union (str.to_re (seq.++ "p" (seq.++ "a" "")))(re.union (str.to_re (seq.++ "P" (seq.++ "A" "")))(re.union (str.to_re (seq.++ "p" (seq.++ "b" "")))(re.union (str.to_re (seq.++ "P" (seq.++ "B" "")))(re.union (str.to_re (seq.++ "p" (seq.++ "e" "")))(re.union (str.to_re (seq.++ "P" (seq.++ "E" "")))(re.union (str.to_re (seq.++ "p" (seq.++ "i" "")))(re.union (str.to_re (seq.++ "P" (seq.++ "I" "")))(re.union (str.to_re (seq.++ "p" (seq.++ "r" "")))(re.union (str.to_re (seq.++ "P" (seq.++ "R" "")))(re.union (str.to_re (seq.++ "r" (seq.++ "j" "")))(re.union (str.to_re (seq.++ "R" (seq.++ "J" "")))(re.union (str.to_re (seq.++ "r" (seq.++ "n" "")))(re.union (str.to_re (seq.++ "R" (seq.++ "N" "")))(re.union (str.to_re (seq.++ "r" (seq.++ "o" "")))(re.union (str.to_re (seq.++ "R" (seq.++ "O" "")))(re.union (str.to_re (seq.++ "r" (seq.++ "r" "")))(re.union (str.to_re (seq.++ "R" (seq.++ "R" "")))(re.union (str.to_re (seq.++ "r" (seq.++ "s" "")))(re.union (str.to_re (seq.++ "R" (seq.++ "S" "")))(re.union (str.to_re (seq.++ "s" (seq.++ "c" "")))(re.union (str.to_re (seq.++ "S" (seq.++ "C" "")))(re.union (str.to_re (seq.++ "s" (seq.++ "e" "")))(re.union (str.to_re (seq.++ "S" (seq.++ "E" "")))(re.union (str.to_re (seq.++ "s" (seq.++ "p" "")))(re.union (str.to_re (seq.++ "S" (seq.++ "P" "")))(re.union (str.to_re (seq.++ "t" (seq.++ "o" ""))) (str.to_re (seq.++ "T" (seq.++ "O" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
