;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \\red([01]?\d\d?|2[0-4]\d|25[0-5])\\green([01]?\d\d?|2[0-4]\d|25[0-5])\\blue([01]?\d\d?|2[0-4]\d|25[0-5]);
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+\u0086\red241\green254\blue208;H\u00B3"
(define-fun Witness1 () String (str.++ "+" (str.++ "\u{86}" (str.++ "\u{5c}" (str.++ "r" (str.++ "e" (str.++ "d" (str.++ "2" (str.++ "4" (str.++ "1" (str.++ "\u{5c}" (str.++ "g" (str.++ "r" (str.++ "e" (str.++ "e" (str.++ "n" (str.++ "2" (str.++ "5" (str.++ "4" (str.++ "\u{5c}" (str.++ "b" (str.++ "l" (str.++ "u" (str.++ "e" (str.++ "2" (str.++ "0" (str.++ "8" (str.++ ";" (str.++ "H" (str.++ "\u{b3}" ""))))))))))))))))))))))))))))))
;witness2: "\red252\green98\blue218;"
(define-fun Witness2 () String (str.++ "\u{5c}" (str.++ "r" (str.++ "e" (str.++ "d" (str.++ "2" (str.++ "5" (str.++ "2" (str.++ "\u{5c}" (str.++ "g" (str.++ "r" (str.++ "e" (str.++ "e" (str.++ "n" (str.++ "9" (str.++ "8" (str.++ "\u{5c}" (str.++ "b" (str.++ "l" (str.++ "u" (str.++ "e" (str.++ "2" (str.++ "1" (str.++ "8" (str.++ ";" "")))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "\u{5c}" (str.++ "r" (str.++ "e" (str.++ "d" "")))))(re.++ (re.union (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))))(re.++ (str.to_re (str.++ "\u{5c}" (str.++ "g" (str.++ "r" (str.++ "e" (str.++ "e" (str.++ "n" "")))))))(re.++ (re.union (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))))(re.++ (str.to_re (str.++ "\u{5c}" (str.++ "b" (str.++ "l" (str.++ "u" (str.++ "e" ""))))))(re.++ (re.union (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5")))) (re.range ";" ";")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
