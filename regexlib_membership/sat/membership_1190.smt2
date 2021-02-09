;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (0[1-9]|[12][0-9]|30)\s(April|June|(Sept|Nov)ember)\s[1-9][0-9]{3}|
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ""
(define-fun Witness1 () String "")
;witness2: ""
(define-fun Witness2 () String "")

(assert (= regexA (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (str.to_re (seq.++ "3" (seq.++ "0" "")))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.union (str.to_re (seq.++ "A" (seq.++ "p" (seq.++ "r" (seq.++ "i" (seq.++ "l" ""))))))(re.union (str.to_re (seq.++ "J" (seq.++ "u" (seq.++ "n" (seq.++ "e" ""))))) (re.++ (re.union (str.to_re (seq.++ "S" (seq.++ "e" (seq.++ "p" (seq.++ "t" ""))))) (str.to_re (seq.++ "N" (seq.++ "o" (seq.++ "v" ""))))) (str.to_re (seq.++ "e" (seq.++ "m" (seq.++ "b" (seq.++ "e" (seq.++ "r" "")))))))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.range "1" "9") ((_ re.loop 3 3) (re.range "0" "9"))))))) (str.to_re ""))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
