;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(big5|euc(kr|jpms)|binary|greek|tis620|hebrew|ascii|swe7|koi8(r|u)|(u|keyb)cs2|(dec|hp|utf|geostd|armscii)8|gb(k|2312)|cp(8(5(0|2)|66)|932|125(0|1|6|7))|latin(1|2|5|7)|(u|s)jis|mac(ce|roman))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "dec8"
(define-fun Witness1 () String (seq.++ "d" (seq.++ "e" (seq.++ "c" (seq.++ "8" "")))))
;witness2: "ascii"
(define-fun Witness2 () String (seq.++ "a" (seq.++ "s" (seq.++ "c" (seq.++ "i" (seq.++ "i" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (seq.++ "b" (seq.++ "i" (seq.++ "g" (seq.++ "5" "")))))(re.union (re.++ (str.to_re (seq.++ "e" (seq.++ "u" (seq.++ "c" "")))) (re.union (str.to_re (seq.++ "k" (seq.++ "r" ""))) (str.to_re (seq.++ "j" (seq.++ "p" (seq.++ "m" (seq.++ "s" "")))))))(re.union (str.to_re (seq.++ "b" (seq.++ "i" (seq.++ "n" (seq.++ "a" (seq.++ "r" (seq.++ "y" "")))))))(re.union (str.to_re (seq.++ "g" (seq.++ "r" (seq.++ "e" (seq.++ "e" (seq.++ "k" ""))))))(re.union (str.to_re (seq.++ "t" (seq.++ "i" (seq.++ "s" (seq.++ "6" (seq.++ "2" (seq.++ "0" "")))))))(re.union (str.to_re (seq.++ "h" (seq.++ "e" (seq.++ "b" (seq.++ "r" (seq.++ "e" (seq.++ "w" "")))))))(re.union (str.to_re (seq.++ "a" (seq.++ "s" (seq.++ "c" (seq.++ "i" (seq.++ "i" ""))))))(re.union (str.to_re (seq.++ "s" (seq.++ "w" (seq.++ "e" (seq.++ "7" "")))))(re.union (re.++ (str.to_re (seq.++ "k" (seq.++ "o" (seq.++ "i" (seq.++ "8" ""))))) (re.union (re.range "r" "r") (re.range "u" "u")))(re.union (re.++ (re.union (re.range "u" "u") (str.to_re (seq.++ "k" (seq.++ "e" (seq.++ "y" (seq.++ "b" "")))))) (str.to_re (seq.++ "c" (seq.++ "s" (seq.++ "2" "")))))(re.union (re.++ (re.union (str.to_re (seq.++ "d" (seq.++ "e" (seq.++ "c" ""))))(re.union (str.to_re (seq.++ "h" (seq.++ "p" "")))(re.union (str.to_re (seq.++ "u" (seq.++ "t" (seq.++ "f" ""))))(re.union (str.to_re (seq.++ "g" (seq.++ "e" (seq.++ "o" (seq.++ "s" (seq.++ "t" (seq.++ "d" ""))))))) (str.to_re (seq.++ "a" (seq.++ "r" (seq.++ "m" (seq.++ "s" (seq.++ "c" (seq.++ "i" (seq.++ "i" "")))))))))))) (re.range "8" "8"))(re.union (re.++ (str.to_re (seq.++ "g" (seq.++ "b" ""))) (re.union (re.range "k" "k") (str.to_re (seq.++ "2" (seq.++ "3" (seq.++ "1" (seq.++ "2" "")))))))(re.union (re.++ (str.to_re (seq.++ "c" (seq.++ "p" ""))) (re.union (re.++ (re.range "8" "8") (re.union (re.++ (re.range "5" "5") (re.union (re.range "0" "0") (re.range "2" "2"))) (str.to_re (seq.++ "6" (seq.++ "6" "")))))(re.union (str.to_re (seq.++ "9" (seq.++ "3" (seq.++ "2" "")))) (re.++ (str.to_re (seq.++ "1" (seq.++ "2" (seq.++ "5" "")))) (re.union (re.range "0" "1") (re.range "6" "7"))))))(re.union (re.++ (str.to_re (seq.++ "l" (seq.++ "a" (seq.++ "t" (seq.++ "i" (seq.++ "n" "")))))) (re.union (re.range "1" "2")(re.union (re.range "5" "5") (re.range "7" "7"))))(re.union (re.++ (re.union (re.range "s" "s") (re.range "u" "u")) (str.to_re (seq.++ "j" (seq.++ "i" (seq.++ "s" ""))))) (re.++ (str.to_re (seq.++ "m" (seq.++ "a" (seq.++ "c" "")))) (re.union (str.to_re (seq.++ "c" (seq.++ "e" ""))) (str.to_re (seq.++ "r" (seq.++ "o" (seq.++ "m" (seq.++ "a" (seq.++ "n" ""))))))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
