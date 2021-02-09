;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((5[1-5])([0-9]{2})((-|\s)?[0-9]{4}){3})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "5165 97893549\u00A02583"
(define-fun Witness1 () String (seq.++ "5" (seq.++ "1" (seq.++ "6" (seq.++ "5" (seq.++ " " (seq.++ "9" (seq.++ "7" (seq.++ "8" (seq.++ "9" (seq.++ "3" (seq.++ "5" (seq.++ "4" (seq.++ "9" (seq.++ "\xa0" (seq.++ "2" (seq.++ "5" (seq.++ "8" (seq.++ "3" "")))))))))))))))))))
;witness2: "54986898\x99955\u00A08899"
(define-fun Witness2 () String (seq.++ "5" (seq.++ "4" (seq.++ "9" (seq.++ "8" (seq.++ "6" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "\x09" (seq.++ "9" (seq.++ "9" (seq.++ "5" (seq.++ "5" (seq.++ "\xa0" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "9" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.++ (re.range "5" "5") (re.range "1" "5"))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) ((_ re.loop 3 3) (re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) ((_ re.loop 4 4) (re.range "0" "9")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
