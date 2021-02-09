;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^ ?(([BEGLMNSWbeglmnsw][0-9][0-9]?)|(([A-PR-UWYZa-pr-uwyz][A-HK-Ya-hk-y][0-9][0-9]?)|(([ENWenw][0-9][A-HJKSTUWa-hjkstuw])|([ENWenw][A-HK-Ya-hk-y][0-9][ABEHMNPRVWXYabehmnprvwxy])))) ?[0-9][ABD-HJLNP-UW-Zabd-hjlnp-uw-z]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "wy8Y 8Ue"
(define-fun Witness1 () String (seq.++ "w" (seq.++ "y" (seq.++ "8" (seq.++ "Y" (seq.++ " " (seq.++ "8" (seq.++ "U" (seq.++ "e" "")))))))))
;witness2: " YA89zw"
(define-fun Witness2 () String (seq.++ " " (seq.++ "Y" (seq.++ "A" (seq.++ "8" (seq.++ "9" (seq.++ "z" (seq.++ "w" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range " " " "))(re.++ (re.union (re.++ (re.union (re.range "B" "B")(re.union (re.range "E" "E")(re.union (re.range "G" "G")(re.union (re.range "L" "N")(re.union (re.range "S" "S")(re.union (re.range "W" "W")(re.union (re.range "b" "b")(re.union (re.range "e" "e")(re.union (re.range "g" "g")(re.union (re.range "l" "n")(re.union (re.range "s" "s") (re.range "w" "w"))))))))))))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))) (re.union (re.++ (re.union (re.range "A" "P")(re.union (re.range "R" "U")(re.union (re.range "W" "W")(re.union (re.range "Y" "Z")(re.union (re.range "a" "p")(re.union (re.range "r" "u")(re.union (re.range "w" "w") (re.range "y" "z"))))))))(re.++ (re.union (re.range "A" "H")(re.union (re.range "K" "Y")(re.union (re.range "a" "h") (re.range "k" "y"))))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))) (re.union (re.++ (re.union (re.range "E" "E")(re.union (re.range "N" "N")(re.union (re.range "W" "W")(re.union (re.range "e" "e")(re.union (re.range "n" "n") (re.range "w" "w"))))))(re.++ (re.range "0" "9") (re.union (re.range "A" "H")(re.union (re.range "J" "K")(re.union (re.range "S" "U")(re.union (re.range "W" "W")(re.union (re.range "a" "h")(re.union (re.range "j" "k")(re.union (re.range "s" "u") (re.range "w" "w")))))))))) (re.++ (re.union (re.range "E" "E")(re.union (re.range "N" "N")(re.union (re.range "W" "W")(re.union (re.range "e" "e")(re.union (re.range "n" "n") (re.range "w" "w"))))))(re.++ (re.union (re.range "A" "H")(re.union (re.range "K" "Y")(re.union (re.range "a" "h") (re.range "k" "y"))))(re.++ (re.range "0" "9") (re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "M" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "R")(re.union (re.range "V" "Y")(re.union (re.range "a" "b")(re.union (re.range "e" "e")(re.union (re.range "h" "h")(re.union (re.range "m" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "r") (re.range "v" "y"))))))))))))))))))))(re.++ (re.opt (re.range " " " "))(re.++ (re.range "0" "9")(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "B")(re.union (re.range "D" "H")(re.union (re.range "J" "J")(re.union (re.range "L" "L")(re.union (re.range "N" "N")(re.union (re.range "P" "U")(re.union (re.range "W" "Z")(re.union (re.range "a" "b")(re.union (re.range "d" "h")(re.union (re.range "j" "j")(re.union (re.range "l" "l")(re.union (re.range "n" "n")(re.union (re.range "p" "u") (re.range "w" "z"))))))))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
