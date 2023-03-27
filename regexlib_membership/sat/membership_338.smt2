;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0369]*([147][0369]*([147][0369]*[258])*[0369]*[147][0369]*([258][0369]*[147])*[0369]*[0369]*([258][0369]*[147])*[0369]*[147]|[258][0369]*([258][0369]*[147])*[0369]*[258][0369]*([147][0369]*[258])*[0369]*[0369]*([147][0369]*[258])*[0369]*[258]|[147][0369]*([147][0369]*[258])*[0369]*[258]|[258][0369]*([258][0369]*[147])*[0369]*[147])*[0369]*)*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ""
(define-fun Witness1 () String "")
;witness2: "\u00C0198995\u008E\u00EE"
(define-fun Witness2 () String (str.++ "\u{c0}" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "5" (str.++ "\u{8e}" (str.++ "\u{ee}" ""))))))))))

(assert (= regexA (re.* (re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9")))))(re.++ (re.* (re.union (re.++ (re.union (re.range "1" "1")(re.union (re.range "4" "4") (re.range "7" "7")))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9")))))(re.++ (re.* (re.++ (re.union (re.range "1" "1")(re.union (re.range "4" "4") (re.range "7" "7")))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9"))))) (re.union (re.range "2" "2")(re.union (re.range "5" "5") (re.range "8" "8"))))))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9")))))(re.++ (re.union (re.range "1" "1")(re.union (re.range "4" "4") (re.range "7" "7")))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9")))))(re.++ (re.* (re.++ (re.union (re.range "2" "2")(re.union (re.range "5" "5") (re.range "8" "8")))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9"))))) (re.union (re.range "1" "1")(re.union (re.range "4" "4") (re.range "7" "7"))))))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9")))))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9")))))(re.++ (re.* (re.++ (re.union (re.range "2" "2")(re.union (re.range "5" "5") (re.range "8" "8")))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9"))))) (re.union (re.range "1" "1")(re.union (re.range "4" "4") (re.range "7" "7"))))))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9"))))) (re.union (re.range "1" "1")(re.union (re.range "4" "4") (re.range "7" "7"))))))))))))))(re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "5" "5") (re.range "8" "8")))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9")))))(re.++ (re.* (re.++ (re.union (re.range "2" "2")(re.union (re.range "5" "5") (re.range "8" "8")))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9"))))) (re.union (re.range "1" "1")(re.union (re.range "4" "4") (re.range "7" "7"))))))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9")))))(re.++ (re.union (re.range "2" "2")(re.union (re.range "5" "5") (re.range "8" "8")))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9")))))(re.++ (re.* (re.++ (re.union (re.range "1" "1")(re.union (re.range "4" "4") (re.range "7" "7")))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9"))))) (re.union (re.range "2" "2")(re.union (re.range "5" "5") (re.range "8" "8"))))))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9")))))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9")))))(re.++ (re.* (re.++ (re.union (re.range "1" "1")(re.union (re.range "4" "4") (re.range "7" "7")))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9"))))) (re.union (re.range "2" "2")(re.union (re.range "5" "5") (re.range "8" "8"))))))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9"))))) (re.union (re.range "2" "2")(re.union (re.range "5" "5") (re.range "8" "8"))))))))))))))(re.union (re.++ (re.union (re.range "1" "1")(re.union (re.range "4" "4") (re.range "7" "7")))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9")))))(re.++ (re.* (re.++ (re.union (re.range "1" "1")(re.union (re.range "4" "4") (re.range "7" "7")))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9"))))) (re.union (re.range "2" "2")(re.union (re.range "5" "5") (re.range "8" "8"))))))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9"))))) (re.union (re.range "2" "2")(re.union (re.range "5" "5") (re.range "8" "8"))))))) (re.++ (re.union (re.range "2" "2")(re.union (re.range "5" "5") (re.range "8" "8")))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9")))))(re.++ (re.* (re.++ (re.union (re.range "2" "2")(re.union (re.range "5" "5") (re.range "8" "8")))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9"))))) (re.union (re.range "1" "1")(re.union (re.range "4" "4") (re.range "7" "7"))))))(re.++ (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9"))))) (re.union (re.range "1" "1")(re.union (re.range "4" "4") (re.range "7" "7"))))))))))) (re.* (re.union (re.range "0" "0")(re.union (re.range "3" "3")(re.union (re.range "6" "6") (re.range "9" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
