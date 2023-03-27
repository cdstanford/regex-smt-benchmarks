;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([A-PR-UWYZa-pr-uwyz]([0-9]{1,2}|([A-HK-Ya-hk-y][0-9]|[A-HK-Ya-hk-y][0-9]([0-9]|[ABEHMNPRV-Yabehmnprv-y]))|[0-9][A-HJKS-UWa-hjks-uw]))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "}wx89"
(define-fun Witness1 () String (str.++ "}" (str.++ "w" (str.++ "x" (str.++ "8" (str.++ "9" ""))))))
;witness2: "c09"
(define-fun Witness2 () String (str.++ "c" (str.++ "0" (str.++ "9" ""))))

(assert (= regexA (re.++ (re.union (re.range "A" "P")(re.union (re.range "R" "U")(re.union (re.range "W" "W")(re.union (re.range "Y" "Z")(re.union (re.range "a" "p")(re.union (re.range "r" "u")(re.union (re.range "w" "w") (re.range "y" "z")))))))) (re.union ((_ re.loop 1 2) (re.range "0" "9"))(re.union (re.union (re.++ (re.union (re.range "A" "H")(re.union (re.range "K" "Y")(re.union (re.range "a" "h") (re.range "k" "y")))) (re.range "0" "9")) (re.++ (re.union (re.range "A" "H")(re.union (re.range "K" "Y")(re.union (re.range "a" "h") (re.range "k" "y"))))(re.++ (re.range "0" "9") (re.union (re.range "0" "9")(re.union (re.range "A" "B")(re.union (re.range "E" "E")(re.union (re.range "H" "H")(re.union (re.range "M" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "R")(re.union (re.range "V" "Y")(re.union (re.range "a" "b")(re.union (re.range "e" "e")(re.union (re.range "h" "h")(re.union (re.range "m" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "r") (re.range "v" "y")))))))))))))))))) (re.++ (re.range "0" "9") (re.union (re.range "A" "H")(re.union (re.range "J" "K")(re.union (re.range "S" "U")(re.union (re.range "W" "W")(re.union (re.range "a" "h")(re.union (re.range "j" "k")(re.union (re.range "s" "u") (re.range "w" "w"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
