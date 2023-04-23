;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(big5|euc(kr|jpms)|binary|greek|tis620|hebrew|ascii|swe7|koi8(r|u)|(u|keyb)cs2|(dec|hp|utf|geostd|armscii)8|gb(k|2312)|cp(8(5(0|2)|66)|932|125(0|1|6|7))|latin(1|2|5|7)|(u|s)jis|mac(ce|roman))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "dec8"
(define-fun Witness1 () String (str.++ "d" (str.++ "e" (str.++ "c" (str.++ "8" "")))))
;witness2: "ascii"
(define-fun Witness2 () String (str.++ "a" (str.++ "s" (str.++ "c" (str.++ "i" (str.++ "i" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (str.++ "b" (str.++ "i" (str.++ "g" (str.++ "5" "")))))(re.union (re.++ (str.to_re (str.++ "e" (str.++ "u" (str.++ "c" "")))) (re.union (str.to_re (str.++ "k" (str.++ "r" ""))) (str.to_re (str.++ "j" (str.++ "p" (str.++ "m" (str.++ "s" "")))))))(re.union (str.to_re (str.++ "b" (str.++ "i" (str.++ "n" (str.++ "a" (str.++ "r" (str.++ "y" "")))))))(re.union (str.to_re (str.++ "g" (str.++ "r" (str.++ "e" (str.++ "e" (str.++ "k" ""))))))(re.union (str.to_re (str.++ "t" (str.++ "i" (str.++ "s" (str.++ "6" (str.++ "2" (str.++ "0" "")))))))(re.union (str.to_re (str.++ "h" (str.++ "e" (str.++ "b" (str.++ "r" (str.++ "e" (str.++ "w" "")))))))(re.union (str.to_re (str.++ "a" (str.++ "s" (str.++ "c" (str.++ "i" (str.++ "i" ""))))))(re.union (str.to_re (str.++ "s" (str.++ "w" (str.++ "e" (str.++ "7" "")))))(re.union (re.++ (str.to_re (str.++ "k" (str.++ "o" (str.++ "i" (str.++ "8" ""))))) (re.union (re.range "r" "r") (re.range "u" "u")))(re.union (re.++ (re.union (re.range "u" "u") (str.to_re (str.++ "k" (str.++ "e" (str.++ "y" (str.++ "b" "")))))) (str.to_re (str.++ "c" (str.++ "s" (str.++ "2" "")))))(re.union (re.++ (re.union (str.to_re (str.++ "d" (str.++ "e" (str.++ "c" ""))))(re.union (str.to_re (str.++ "h" (str.++ "p" "")))(re.union (str.to_re (str.++ "u" (str.++ "t" (str.++ "f" ""))))(re.union (str.to_re (str.++ "g" (str.++ "e" (str.++ "o" (str.++ "s" (str.++ "t" (str.++ "d" ""))))))) (str.to_re (str.++ "a" (str.++ "r" (str.++ "m" (str.++ "s" (str.++ "c" (str.++ "i" (str.++ "i" "")))))))))))) (re.range "8" "8"))(re.union (re.++ (str.to_re (str.++ "g" (str.++ "b" ""))) (re.union (re.range "k" "k") (str.to_re (str.++ "2" (str.++ "3" (str.++ "1" (str.++ "2" "")))))))(re.union (re.++ (str.to_re (str.++ "c" (str.++ "p" ""))) (re.union (re.++ (re.range "8" "8") (re.union (re.++ (re.range "5" "5") (re.union (re.range "0" "0") (re.range "2" "2"))) (str.to_re (str.++ "6" (str.++ "6" "")))))(re.union (str.to_re (str.++ "9" (str.++ "3" (str.++ "2" "")))) (re.++ (str.to_re (str.++ "1" (str.++ "2" (str.++ "5" "")))) (re.union (re.range "0" "1") (re.range "6" "7"))))))(re.union (re.++ (str.to_re (str.++ "l" (str.++ "a" (str.++ "t" (str.++ "i" (str.++ "n" "")))))) (re.union (re.range "1" "2")(re.union (re.range "5" "5") (re.range "7" "7"))))(re.union (re.++ (re.union (re.range "s" "s") (re.range "u" "u")) (str.to_re (str.++ "j" (str.++ "i" (str.++ "s" ""))))) (re.++ (str.to_re (str.++ "m" (str.++ "a" (str.++ "c" "")))) (re.union (str.to_re (str.++ "c" (str.++ "e" ""))) (str.to_re (str.++ "r" (str.++ "o" (str.++ "m" (str.++ "a" (str.++ "n" ""))))))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
