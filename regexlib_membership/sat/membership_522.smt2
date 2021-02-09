;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (8[^0]\d|8\d[^0]|[0-79]\d{2})-\d{3}-\d{4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "}87\u007F-884-5996u"
(define-fun Witness1 () String (seq.++ "}" (seq.++ "8" (seq.++ "7" (seq.++ "\x7f" (seq.++ "-" (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "-" (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ "6" (seq.++ "u" "")))))))))))))))
;witness2: "89s-856-0990\u0080"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "9" (seq.++ "s" (seq.++ "-" (seq.++ "8" (seq.++ "5" (seq.++ "6" (seq.++ "-" (seq.++ "0" (seq.++ "9" (seq.++ "9" (seq.++ "0" (seq.++ "\x80" ""))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.range "8" "8")(re.++ (re.union (re.range "\x00" "/") (re.range "1" "\xff")) (re.range "0" "9")))(re.union (re.++ (re.range "8" "8")(re.++ (re.range "0" "9") (re.union (re.range "\x00" "/") (re.range "1" "\xff")))) (re.++ (re.union (re.range "0" "7") (re.range "9" "9")) ((_ re.loop 2 2) (re.range "0" "9")))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
