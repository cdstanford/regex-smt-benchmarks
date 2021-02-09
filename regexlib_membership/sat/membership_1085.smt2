;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \\red([01]?\d\d?|2[0-4]\d|25[0-5])\\green([01]?\d\d?|2[0-4]\d|25[0-5])\\blue([01]?\d\d?|2[0-4]\d|25[0-5]);
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+\u0086\red241\green254\blue208;H\u00B3"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "\x86" (seq.++ "\x5c" (seq.++ "r" (seq.++ "e" (seq.++ "d" (seq.++ "2" (seq.++ "4" (seq.++ "1" (seq.++ "\x5c" (seq.++ "g" (seq.++ "r" (seq.++ "e" (seq.++ "e" (seq.++ "n" (seq.++ "2" (seq.++ "5" (seq.++ "4" (seq.++ "\x5c" (seq.++ "b" (seq.++ "l" (seq.++ "u" (seq.++ "e" (seq.++ "2" (seq.++ "0" (seq.++ "8" (seq.++ ";" (seq.++ "H" (seq.++ "\xb3" ""))))))))))))))))))))))))))))))
;witness2: "\red252\green98\blue218;"
(define-fun Witness2 () String (seq.++ "\x5c" (seq.++ "r" (seq.++ "e" (seq.++ "d" (seq.++ "2" (seq.++ "5" (seq.++ "2" (seq.++ "\x5c" (seq.++ "g" (seq.++ "r" (seq.++ "e" (seq.++ "e" (seq.++ "n" (seq.++ "9" (seq.++ "8" (seq.++ "\x5c" (seq.++ "b" (seq.++ "l" (seq.++ "u" (seq.++ "e" (seq.++ "2" (seq.++ "1" (seq.++ "8" (seq.++ ";" "")))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "\x5c" (seq.++ "r" (seq.++ "e" (seq.++ "d" "")))))(re.++ (re.union (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))))(re.++ (str.to_re (seq.++ "\x5c" (seq.++ "g" (seq.++ "r" (seq.++ "e" (seq.++ "e" (seq.++ "n" "")))))))(re.++ (re.union (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))))(re.++ (str.to_re (seq.++ "\x5c" (seq.++ "b" (seq.++ "l" (seq.++ "u" (seq.++ "e" ""))))))(re.++ (re.union (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5")))) (re.range ";" ";")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
