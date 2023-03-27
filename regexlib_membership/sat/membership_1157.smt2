;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z1-9]{5}-[A-Z1-9]{5}-[A-Z1-9]{5}-[A-Z1-9]{5}-[A-Z1-9]{5}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Z94XA-Y88D8-TSU2D-843MT-X2C1W"
(define-fun Witness1 () String (str.++ "Z" (str.++ "9" (str.++ "4" (str.++ "X" (str.++ "A" (str.++ "-" (str.++ "Y" (str.++ "8" (str.++ "8" (str.++ "D" (str.++ "8" (str.++ "-" (str.++ "T" (str.++ "S" (str.++ "U" (str.++ "2" (str.++ "D" (str.++ "-" (str.++ "8" (str.++ "4" (str.++ "3" (str.++ "M" (str.++ "T" (str.++ "-" (str.++ "X" (str.++ "2" (str.++ "C" (str.++ "1" (str.++ "W" ""))))))))))))))))))))))))))))))
;witness2: "LUMI9-91TZC-7183Z-9T8EZ-4R8A8"
(define-fun Witness2 () String (str.++ "L" (str.++ "U" (str.++ "M" (str.++ "I" (str.++ "9" (str.++ "-" (str.++ "9" (str.++ "1" (str.++ "T" (str.++ "Z" (str.++ "C" (str.++ "-" (str.++ "7" (str.++ "1" (str.++ "8" (str.++ "3" (str.++ "Z" (str.++ "-" (str.++ "9" (str.++ "T" (str.++ "8" (str.++ "E" (str.++ "Z" (str.++ "-" (str.++ "4" (str.++ "R" (str.++ "8" (str.++ "A" (str.++ "8" ""))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.union (re.range "1" "9") (re.range "A" "Z")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 5 5) (re.union (re.range "1" "9") (re.range "A" "Z")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 5 5) (re.union (re.range "1" "9") (re.range "A" "Z")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 5 5) (re.union (re.range "1" "9") (re.range "A" "Z")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 5 5) (re.union (re.range "1" "9") (re.range "A" "Z"))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
