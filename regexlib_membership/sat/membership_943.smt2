;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .*(\.[Jj][Pp][Gg]|\.[Gg][Ii][Ff]|\.[Jj][Pp][Ee][Gg]|\.[Pp][Nn][Gg])
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ".jPG\u007F"
(define-fun Witness1 () String (str.++ "." (str.++ "j" (str.++ "P" (str.++ "G" (str.++ "\u{7f}" ""))))))
;witness2: ".JPG\u00E9x"
(define-fun Witness2 () String (str.++ "." (str.++ "J" (str.++ "P" (str.++ "G" (str.++ "\u{e9}" (str.++ "x" "")))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.union (re.++ (re.range "." ".")(re.++ (re.union (re.range "J" "J") (re.range "j" "j"))(re.++ (re.union (re.range "P" "P") (re.range "p" "p")) (re.union (re.range "G" "G") (re.range "g" "g")))))(re.union (re.++ (re.range "." ".")(re.++ (re.union (re.range "G" "G") (re.range "g" "g"))(re.++ (re.union (re.range "I" "I") (re.range "i" "i")) (re.union (re.range "F" "F") (re.range "f" "f")))))(re.union (re.++ (re.range "." ".")(re.++ (re.union (re.range "J" "J") (re.range "j" "j"))(re.++ (re.union (re.range "P" "P") (re.range "p" "p"))(re.++ (re.union (re.range "E" "E") (re.range "e" "e")) (re.union (re.range "G" "G") (re.range "g" "g")))))) (re.++ (re.range "." ".")(re.++ (re.union (re.range "P" "P") (re.range "p" "p"))(re.++ (re.union (re.range "N" "N") (re.range "n" "n")) (re.union (re.range "G" "G") (re.range "g" "g")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
