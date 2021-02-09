;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .*(\.[Jj][Pp][Gg]|\.[Gg][Ii][Ff]|\.[Jj][Pp][Ee][Gg]|\.[Pp][Nn][Gg])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ".jPG\u007F"
(define-fun Witness1 () String (seq.++ "." (seq.++ "j" (seq.++ "P" (seq.++ "G" (seq.++ "\x7f" ""))))))
;witness2: ".JPG\u00E9x"
(define-fun Witness2 () String (seq.++ "." (seq.++ "J" (seq.++ "P" (seq.++ "G" (seq.++ "\xe9" (seq.++ "x" "")))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.union (re.++ (re.range "." ".")(re.++ (re.union (re.range "J" "J") (re.range "j" "j"))(re.++ (re.union (re.range "P" "P") (re.range "p" "p")) (re.union (re.range "G" "G") (re.range "g" "g")))))(re.union (re.++ (re.range "." ".")(re.++ (re.union (re.range "G" "G") (re.range "g" "g"))(re.++ (re.union (re.range "I" "I") (re.range "i" "i")) (re.union (re.range "F" "F") (re.range "f" "f")))))(re.union (re.++ (re.range "." ".")(re.++ (re.union (re.range "J" "J") (re.range "j" "j"))(re.++ (re.union (re.range "P" "P") (re.range "p" "p"))(re.++ (re.union (re.range "E" "E") (re.range "e" "e")) (re.union (re.range "G" "G") (re.range "g" "g")))))) (re.++ (re.range "." ".")(re.++ (re.union (re.range "P" "P") (re.range "p" "p"))(re.++ (re.union (re.range "N" "N") (re.range "n" "n")) (re.union (re.range "G" "G") (re.range "g" "g")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
