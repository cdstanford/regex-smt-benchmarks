;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{2}[9]{3}|[A-Z]{3}[9]{2}|[A-Z]{4}[9]{1}|[A-Z]{5})[0-9]{6}([A-Z]{1}[9]{1}|[A-Z]{2})[A-Z0,9]{3}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "IT999880489K90C9"
(define-fun Witness1 () String (seq.++ "I" (seq.++ "T" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "0" (seq.++ "4" (seq.++ "8" (seq.++ "9" (seq.++ "K" (seq.++ "9" (seq.++ "0" (seq.++ "C" (seq.++ "9" "")))))))))))))))))
;witness2: "QOQSP979920U9,9,"
(define-fun Witness2 () String (seq.++ "Q" (seq.++ "O" (seq.++ "Q" (seq.++ "S" (seq.++ "P" (seq.++ "9" (seq.++ "7" (seq.++ "9" (seq.++ "9" (seq.++ "2" (seq.++ "0" (seq.++ "U" (seq.++ "9" (seq.++ "," (seq.++ "9" (seq.++ "," "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ ((_ re.loop 2 2) (re.range "A" "Z")) ((_ re.loop 3 3) (re.range "9" "9")))(re.union (re.++ ((_ re.loop 3 3) (re.range "A" "Z")) ((_ re.loop 2 2) (re.range "9" "9")))(re.union (re.++ ((_ re.loop 4 4) (re.range "A" "Z")) (re.range "9" "9")) ((_ re.loop 5 5) (re.range "A" "Z")))))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.union (re.++ (re.range "A" "Z") (re.range "9" "9")) ((_ re.loop 2 2) (re.range "A" "Z")))(re.++ ((_ re.loop 3 3) (re.union (re.range "," ",")(re.union (re.range "0" "0")(re.union (re.range "9" "9") (re.range "A" "Z"))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
