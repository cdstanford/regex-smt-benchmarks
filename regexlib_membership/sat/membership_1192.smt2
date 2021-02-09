;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = 29\sFebruary\s((0[48]|[2468][048]|[13579][26])00|[0-9]{2}(0[48]|[2468][048]|[13579][26]))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "29\xAFebruary\u00A00400\u008C"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "9" (seq.++ "\x0a" (seq.++ "F" (seq.++ "e" (seq.++ "b" (seq.++ "r" (seq.++ "u" (seq.++ "a" (seq.++ "r" (seq.++ "y" (seq.++ "\xa0" (seq.++ "0" (seq.++ "4" (seq.++ "0" (seq.++ "0" (seq.++ "\x8c" ""))))))))))))))))))
;witness2: "29\u0085February\xC2400"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "9" (seq.++ "\x85" (seq.++ "F" (seq.++ "e" (seq.++ "b" (seq.++ "r" (seq.++ "u" (seq.++ "a" (seq.++ "r" (seq.++ "y" (seq.++ "\x0c" (seq.++ "2" (seq.++ "4" (seq.++ "0" (seq.++ "0" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "2" (seq.++ "9" "")))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (str.to_re (seq.++ "F" (seq.++ "e" (seq.++ "b" (seq.++ "r" (seq.++ "u" (seq.++ "a" (seq.++ "r" (seq.++ "y" "")))))))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8")))(re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))))) (str.to_re (seq.++ "0" (seq.++ "0" "")))) (re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8")))(re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
