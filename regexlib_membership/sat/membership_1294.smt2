;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(\d{2}.\d{3}.\d{3}/\d{4}-\d{2})|(\d{14})$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "69982134889774"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "2" (seq.++ "1" (seq.++ "3" (seq.++ "4" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "7" (seq.++ "7" (seq.++ "4" "")))))))))))))))
;witness2: "\u00F070898864152268"
(define-fun Witness2 () String (seq.++ "\xf0" (seq.++ "7" (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "6" (seq.++ "4" (seq.++ "1" (seq.++ "5" (seq.++ "2" (seq.++ "2" (seq.++ "6" (seq.++ "8" ""))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "/" "/")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9"))))))))))) (re.++ ((_ re.loop 14 14) (re.range "0" "9")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
