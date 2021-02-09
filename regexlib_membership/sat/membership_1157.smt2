;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z1-9]{5}-[A-Z1-9]{5}-[A-Z1-9]{5}-[A-Z1-9]{5}-[A-Z1-9]{5}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Z94XA-Y88D8-TSU2D-843MT-X2C1W"
(define-fun Witness1 () String (seq.++ "Z" (seq.++ "9" (seq.++ "4" (seq.++ "X" (seq.++ "A" (seq.++ "-" (seq.++ "Y" (seq.++ "8" (seq.++ "8" (seq.++ "D" (seq.++ "8" (seq.++ "-" (seq.++ "T" (seq.++ "S" (seq.++ "U" (seq.++ "2" (seq.++ "D" (seq.++ "-" (seq.++ "8" (seq.++ "4" (seq.++ "3" (seq.++ "M" (seq.++ "T" (seq.++ "-" (seq.++ "X" (seq.++ "2" (seq.++ "C" (seq.++ "1" (seq.++ "W" ""))))))))))))))))))))))))))))))
;witness2: "LUMI9-91TZC-7183Z-9T8EZ-4R8A8"
(define-fun Witness2 () String (seq.++ "L" (seq.++ "U" (seq.++ "M" (seq.++ "I" (seq.++ "9" (seq.++ "-" (seq.++ "9" (seq.++ "1" (seq.++ "T" (seq.++ "Z" (seq.++ "C" (seq.++ "-" (seq.++ "7" (seq.++ "1" (seq.++ "8" (seq.++ "3" (seq.++ "Z" (seq.++ "-" (seq.++ "9" (seq.++ "T" (seq.++ "8" (seq.++ "E" (seq.++ "Z" (seq.++ "-" (seq.++ "4" (seq.++ "R" (seq.++ "8" (seq.++ "A" (seq.++ "8" ""))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.union (re.range "1" "9") (re.range "A" "Z")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 5 5) (re.union (re.range "1" "9") (re.range "A" "Z")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 5 5) (re.union (re.range "1" "9") (re.range "A" "Z")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 5 5) (re.union (re.range "1" "9") (re.range "A" "Z")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 5 5) (re.union (re.range "1" "9") (re.range "A" "Z"))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
