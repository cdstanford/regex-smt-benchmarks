;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((([sS]|[nN])[a-hA-Hj-zJ-Z])|(([tT]|[oO])[abfglmqrvwABFGLMQRVW])|([hH][l-zL-Z])|([jJ][lmqrvwLMQRVW]))([0-9]{2})?([0-9]{2})?([0-9]{2})?([0-9]{2})?([0-9]{2})?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Hu98469788"
(define-fun Witness1 () String (str.++ "H" (str.++ "u" (str.++ "9" (str.++ "8" (str.++ "4" (str.++ "6" (str.++ "9" (str.++ "7" (str.++ "8" (str.++ "8" "")))))))))))
;witness2: "jV886988"
(define-fun Witness2 () String (str.++ "j" (str.++ "V" (str.++ "8" (str.++ "8" (str.++ "6" (str.++ "9" (str.++ "8" (str.++ "8" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "N" "N")(re.union (re.range "S" "S")(re.union (re.range "n" "n") (re.range "s" "s")))) (re.union (re.range "A" "H")(re.union (re.range "J" "Z")(re.union (re.range "a" "h") (re.range "j" "z")))))(re.union (re.++ (re.union (re.range "O" "O")(re.union (re.range "T" "T")(re.union (re.range "o" "o") (re.range "t" "t")))) (re.union (re.range "A" "B")(re.union (re.range "F" "G")(re.union (re.range "L" "M")(re.union (re.range "Q" "R")(re.union (re.range "V" "W")(re.union (re.range "a" "b")(re.union (re.range "f" "g")(re.union (re.range "l" "m")(re.union (re.range "q" "r") (re.range "v" "w")))))))))))(re.union (re.++ (re.union (re.range "H" "H") (re.range "h" "h")) (re.union (re.range "L" "Z") (re.range "l" "z"))) (re.++ (re.union (re.range "J" "J") (re.range "j" "j")) (re.union (re.range "L" "M")(re.union (re.range "Q" "R")(re.union (re.range "V" "W")(re.union (re.range "l" "m")(re.union (re.range "q" "r") (re.range "v" "w"))))))))))(re.++ (re.opt ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt ((_ re.loop 2 2) (re.range "0" "9"))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
