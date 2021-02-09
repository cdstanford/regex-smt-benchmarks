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

;witness1: "542080\u0085328884988997\u00985\"
(define-fun Witness1 () String (seq.++ "5" (seq.++ "4" (seq.++ "2" (seq.++ "0" (seq.++ "8" (seq.++ "0" (seq.++ "\x85" (seq.++ "3" (seq.++ "2" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "7" (seq.++ "\x98" (seq.++ "5" (seq.++ "\x5c" "")))))))))))))))))))))))
;witness2: "\u00D1Y3845\x99709\u00A03994\xC5905"
(define-fun Witness2 () String (seq.++ "\xd1" (seq.++ "Y" (seq.++ "3" (seq.++ "8" (seq.++ "4" (seq.++ "5" (seq.++ "\x09" (seq.++ "9" (seq.++ "7" (seq.++ "0" (seq.++ "9" (seq.++ "\xa0" (seq.++ "3" (seq.++ "9" (seq.++ "9" (seq.++ "4" (seq.++ "\x0c" (seq.++ "5" (seq.++ "9" (seq.++ "0" (seq.++ "5" ""))))))))))))))))))))))

(assert (= regexA (re.union (re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) ((_ re.loop 12 12) (re.range "0" "9")))) (re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) ((_ re.loop 4 4) (re.range "0" "9")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
