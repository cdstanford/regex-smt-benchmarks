;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((([sS]|[nN])[a-hA-Hj-zJ-Z])|(([tT]|[oO])[abfglmqrvwABFGLMQRVW])|([hH][l-zL-Z])|([jJ][lmqrvwLMQRVW]))([0-9]{2})?(([a-np-zA-NP-Z]{1}?|([0-9]{2})?([0-9]{2})?([0-9]{2})?([0-9]{2})?))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0091\x1CNg88G"
(define-fun Witness1 () String (seq.++ "\x91" (seq.++ "\x1c" (seq.++ "N" (seq.++ "g" (seq.++ "8" (seq.++ "8" (seq.++ "G" ""))))))))
;witness2: "jq836189/"
(define-fun Witness2 () String (seq.++ "j" (seq.++ "q" (seq.++ "8" (seq.++ "3" (seq.++ "6" (seq.++ "1" (seq.++ "8" (seq.++ "9" (seq.++ "/" ""))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.union (re.range "N" "N")(re.union (re.range "S" "S")(re.union (re.range "n" "n") (re.range "s" "s")))) (re.union (re.range "A" "H")(re.union (re.range "J" "Z")(re.union (re.range "a" "h") (re.range "j" "z")))))(re.union (re.++ (re.union (re.range "O" "O")(re.union (re.range "T" "T")(re.union (re.range "o" "o") (re.range "t" "t")))) (re.union (re.range "A" "B")(re.union (re.range "F" "G")(re.union (re.range "L" "M")(re.union (re.range "Q" "R")(re.union (re.range "V" "W")(re.union (re.range "a" "b")(re.union (re.range "f" "g")(re.union (re.range "l" "m")(re.union (re.range "q" "r") (re.range "v" "w")))))))))))(re.union (re.++ (re.union (re.range "H" "H") (re.range "h" "h")) (re.union (re.range "L" "Z") (re.range "l" "z"))) (re.++ (re.union (re.range "J" "J") (re.range "j" "j")) (re.union (re.range "L" "M")(re.union (re.range "Q" "R")(re.union (re.range "V" "W")(re.union (re.range "l" "m")(re.union (re.range "q" "r") (re.range "v" "w"))))))))))(re.++ (re.opt ((_ re.loop 2 2) (re.range "0" "9"))) (re.union (re.union (re.range "A" "N")(re.union (re.range "P" "Z")(re.union (re.range "a" "n") (re.range "p" "z")))) (re.++ (re.opt ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt ((_ re.loop 2 2) (re.range "0" "9"))) (re.opt ((_ re.loop 2 2) (re.range "0" "9")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
