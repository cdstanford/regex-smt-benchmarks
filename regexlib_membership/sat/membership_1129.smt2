;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z\d]{3})[A-Z]{2}\d{2}([A-Z\d]{1})([X\d]{1})([A-Z\d]{3})\d{5}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "D78MN74WX92249480"
(define-fun Witness1 () String (seq.++ "D" (seq.++ "7" (seq.++ "8" (seq.++ "M" (seq.++ "N" (seq.++ "7" (seq.++ "4" (seq.++ "W" (seq.++ "X" (seq.++ "9" (seq.++ "2" (seq.++ "2" (seq.++ "4" (seq.++ "9" (seq.++ "4" (seq.++ "8" (seq.++ "0" ""))))))))))))))))))
;witness2: "018IV393X4CE59853"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "1" (seq.++ "8" (seq.++ "I" (seq.++ "V" (seq.++ "3" (seq.++ "9" (seq.++ "3" (seq.++ "X" (seq.++ "4" (seq.++ "C" (seq.++ "E" (seq.++ "5" (seq.++ "9" (seq.++ "8" (seq.++ "5" (seq.++ "3" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ ((_ re.loop 2 2) (re.range "A" "Z"))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "0" "9") (re.range "A" "Z"))(re.++ (re.union (re.range "0" "9") (re.range "X" "X"))(re.++ ((_ re.loop 3 3) (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ ((_ re.loop 5 5) (re.range "0" "9")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
