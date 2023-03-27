;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(ac|AC|al|AL|am|AM|ap|AP|ba|BA|ce|CE|df|DF|es|ES|go|GO|ma|MA|mg|MG|ms|MS|mt|MT|pa|PA|pb|PB|pe|PE|pi|PI|pr|PR|rj|RJ|rn|RN|ro|RO|rr|RR|rs|RS|sc|SC|se|SE|sp|SP|to|TO)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "SP"
(define-fun Witness1 () String (str.++ "S" (str.++ "P" "")))
;witness2: "RO"
(define-fun Witness2 () String (str.++ "R" (str.++ "O" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (str.++ "a" (str.++ "c" "")))(re.union (str.to_re (str.++ "A" (str.++ "C" "")))(re.union (str.to_re (str.++ "a" (str.++ "l" "")))(re.union (str.to_re (str.++ "A" (str.++ "L" "")))(re.union (str.to_re (str.++ "a" (str.++ "m" "")))(re.union (str.to_re (str.++ "A" (str.++ "M" "")))(re.union (str.to_re (str.++ "a" (str.++ "p" "")))(re.union (str.to_re (str.++ "A" (str.++ "P" "")))(re.union (str.to_re (str.++ "b" (str.++ "a" "")))(re.union (str.to_re (str.++ "B" (str.++ "A" "")))(re.union (str.to_re (str.++ "c" (str.++ "e" "")))(re.union (str.to_re (str.++ "C" (str.++ "E" "")))(re.union (str.to_re (str.++ "d" (str.++ "f" "")))(re.union (str.to_re (str.++ "D" (str.++ "F" "")))(re.union (str.to_re (str.++ "e" (str.++ "s" "")))(re.union (str.to_re (str.++ "E" (str.++ "S" "")))(re.union (str.to_re (str.++ "g" (str.++ "o" "")))(re.union (str.to_re (str.++ "G" (str.++ "O" "")))(re.union (str.to_re (str.++ "m" (str.++ "a" "")))(re.union (str.to_re (str.++ "M" (str.++ "A" "")))(re.union (str.to_re (str.++ "m" (str.++ "g" "")))(re.union (str.to_re (str.++ "M" (str.++ "G" "")))(re.union (str.to_re (str.++ "m" (str.++ "s" "")))(re.union (str.to_re (str.++ "M" (str.++ "S" "")))(re.union (str.to_re (str.++ "m" (str.++ "t" "")))(re.union (str.to_re (str.++ "M" (str.++ "T" "")))(re.union (str.to_re (str.++ "p" (str.++ "a" "")))(re.union (str.to_re (str.++ "P" (str.++ "A" "")))(re.union (str.to_re (str.++ "p" (str.++ "b" "")))(re.union (str.to_re (str.++ "P" (str.++ "B" "")))(re.union (str.to_re (str.++ "p" (str.++ "e" "")))(re.union (str.to_re (str.++ "P" (str.++ "E" "")))(re.union (str.to_re (str.++ "p" (str.++ "i" "")))(re.union (str.to_re (str.++ "P" (str.++ "I" "")))(re.union (str.to_re (str.++ "p" (str.++ "r" "")))(re.union (str.to_re (str.++ "P" (str.++ "R" "")))(re.union (str.to_re (str.++ "r" (str.++ "j" "")))(re.union (str.to_re (str.++ "R" (str.++ "J" "")))(re.union (str.to_re (str.++ "r" (str.++ "n" "")))(re.union (str.to_re (str.++ "R" (str.++ "N" "")))(re.union (str.to_re (str.++ "r" (str.++ "o" "")))(re.union (str.to_re (str.++ "R" (str.++ "O" "")))(re.union (str.to_re (str.++ "r" (str.++ "r" "")))(re.union (str.to_re (str.++ "R" (str.++ "R" "")))(re.union (str.to_re (str.++ "r" (str.++ "s" "")))(re.union (str.to_re (str.++ "R" (str.++ "S" "")))(re.union (str.to_re (str.++ "s" (str.++ "c" "")))(re.union (str.to_re (str.++ "S" (str.++ "C" "")))(re.union (str.to_re (str.++ "s" (str.++ "e" "")))(re.union (str.to_re (str.++ "S" (str.++ "E" "")))(re.union (str.to_re (str.++ "s" (str.++ "p" "")))(re.union (str.to_re (str.++ "S" (str.++ "P" "")))(re.union (str.to_re (str.++ "t" (str.++ "o" ""))) (str.to_re (str.++ "T" (str.++ "O" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
