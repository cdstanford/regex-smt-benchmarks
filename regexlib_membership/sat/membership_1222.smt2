;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (077|078|079)\s?\d{2}\s?\d{6}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "078\u00A088\u0085848989K^"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "7" (seq.++ "8" (seq.++ "\xa0" (seq.++ "8" (seq.++ "8" (seq.++ "\x85" (seq.++ "8" (seq.++ "4" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "K" (seq.++ "^" ""))))))))))))))))
;witness2: "\u0086079\u008581291751\u00DAg"
(define-fun Witness2 () String (seq.++ "\x86" (seq.++ "0" (seq.++ "7" (seq.++ "9" (seq.++ "\x85" (seq.++ "8" (seq.++ "1" (seq.++ "2" (seq.++ "9" (seq.++ "1" (seq.++ "7" (seq.++ "5" (seq.++ "1" (seq.++ "\xda" (seq.++ "g" ""))))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (seq.++ "0" (seq.++ "7" (seq.++ "7" ""))))(re.union (str.to_re (seq.++ "0" (seq.++ "7" (seq.++ "8" "")))) (str.to_re (seq.++ "0" (seq.++ "7" (seq.++ "9" ""))))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 6 6) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
