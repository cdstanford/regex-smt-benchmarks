;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (25[0-5]|2[0-4][0-9]|[1][0-9]?[0-9]?|[1-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[1][0-9]?[0-9]?|[1-9][0-9]?|[0])\.(25[0-5]|2[0-4][0-9]|[1][0-9]?[0-9]?|[1-9][0-9]?|[0])\.(25[0-5]|2[0-4][0-9]|[1][0-9]?[0-9]?|[1-9][0-9]?)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "254.8.218.29\u0086"
(define-fun Witness1 () String (str.++ "2" (str.++ "5" (str.++ "4" (str.++ "." (str.++ "8" (str.++ "." (str.++ "2" (str.++ "1" (str.++ "8" (str.++ "." (str.++ "2" (str.++ "9" (str.++ "\u{86}" ""))))))))))))))
;witness2: "\u00D5\x07.249.0.1\u00EC\u00CB"
(define-fun Witness2 () String (str.++ "\u{d5}" (str.++ "\u{00}" (str.++ "7" (str.++ "." (str.++ "2" (str.++ "4" (str.++ "9" (str.++ "." (str.++ "0" (str.++ "." (str.++ "1" (str.++ "\u{ec}" (str.++ "\u{cb}" ""))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.opt (re.range "0" "9")) (re.opt (re.range "0" "9")))) (re.++ (re.range "1" "9") (re.opt (re.range "0" "9"))))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.opt (re.range "0" "9")) (re.opt (re.range "0" "9"))))(re.union (re.++ (re.range "1" "9") (re.opt (re.range "0" "9"))) (re.range "0" "0")))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.opt (re.range "0" "9")) (re.opt (re.range "0" "9"))))(re.union (re.++ (re.range "1" "9") (re.opt (re.range "0" "9"))) (re.range "0" "0")))))(re.++ (re.range "." ".") (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.opt (re.range "0" "9")) (re.opt (re.range "0" "9")))) (re.++ (re.range "1" "9") (re.opt (re.range "0" "9"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
