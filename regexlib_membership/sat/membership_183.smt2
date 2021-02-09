;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^.*([^\.][\.](([gG][iI][fF])|([Jj][pP][Gg])|([Jj][pP][Ee][Gg])|([Bb][mM][pP])|([Pp][nN][Gg])))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00B2.PNg"
(define-fun Witness1 () String (seq.++ "\xb2" (seq.++ "." (seq.++ "P" (seq.++ "N" (seq.++ "g" ""))))))
;witness2: "}\u00C1.BMP\u00D6\u0085\u00F8bn:"
(define-fun Witness2 () String (seq.++ "}" (seq.++ "\xc1" (seq.++ "." (seq.++ "B" (seq.++ "M" (seq.++ "P" (seq.++ "\xd6" (seq.++ "\x85" (seq.++ "\xf8" (seq.++ "b" (seq.++ "n" (seq.++ ":" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.++ (re.union (re.range "\x00" "-") (re.range "/" "\xff"))(re.++ (re.range "." ".") (re.union (re.++ (re.union (re.range "G" "G") (re.range "g" "g"))(re.++ (re.union (re.range "I" "I") (re.range "i" "i")) (re.union (re.range "F" "F") (re.range "f" "f"))))(re.union (re.++ (re.union (re.range "J" "J") (re.range "j" "j"))(re.++ (re.union (re.range "P" "P") (re.range "p" "p")) (re.union (re.range "G" "G") (re.range "g" "g"))))(re.union (re.++ (re.union (re.range "J" "J") (re.range "j" "j"))(re.++ (re.union (re.range "P" "P") (re.range "p" "p"))(re.++ (re.union (re.range "E" "E") (re.range "e" "e")) (re.union (re.range "G" "G") (re.range "g" "g")))))(re.union (re.++ (re.union (re.range "B" "B") (re.range "b" "b"))(re.++ (re.union (re.range "M" "M") (re.range "m" "m")) (re.union (re.range "P" "P") (re.range "p" "p")))) (re.++ (re.union (re.range "P" "P") (re.range "p" "p"))(re.++ (re.union (re.range "N" "N") (re.range "n" "n")) (re.union (re.range "G" "G") (re.range "g" "g"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
