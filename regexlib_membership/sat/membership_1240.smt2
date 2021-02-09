;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\d{6}[-\s]?\d{12})|(\d{4}[-\s]?\d{4}[-\s]?\d{4}[-\s]?\d{4})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0090.\u00860339\u00859774\xC9989\u00859998"
(define-fun Witness1 () String (seq.++ "\x90" (seq.++ "." (seq.++ "\x86" (seq.++ "0" (seq.++ "3" (seq.++ "3" (seq.++ "9" (seq.++ "\x85" (seq.++ "9" (seq.++ "7" (seq.++ "7" (seq.++ "4" (seq.++ "\x0c" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "\x85" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "8" "")))))))))))))))))))))))
;witness2: "\u0082\x11889891990899\u00858939"
(define-fun Witness2 () String (seq.++ "\x82" (seq.++ "\x11" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "1" (seq.++ "9" (seq.++ "9" (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "\x85" (seq.++ "8" (seq.++ "9" (seq.++ "3" (seq.++ "9" ""))))))))))))))))))))

(assert (= regexA (re.union (re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) ((_ re.loop 12 12) (re.range "0" "9")))) (re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) ((_ re.loop 4 4) (re.range "0" "9")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
