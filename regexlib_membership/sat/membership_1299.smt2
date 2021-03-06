;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(\d{3}.\d{3}.\d{3}-\d{2})|(\d{11})$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "386D385\u00BE939-69"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "8" (seq.++ "6" (seq.++ "D" (seq.++ "3" (seq.++ "8" (seq.++ "5" (seq.++ "\xbe" (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ "-" (seq.++ "6" (seq.++ "9" "")))))))))))))))
;witness2: "A92495984481"
(define-fun Witness2 () String (seq.++ "A" (seq.++ "9" (seq.++ "2" (seq.++ "4" (seq.++ "9" (seq.++ "5" (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "4" (seq.++ "8" (seq.++ "1" "")))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9"))))))))) (re.++ ((_ re.loop 11 11) (re.range "0" "9")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
