;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [A-Z0-9]{5}\d[0156]\d([0][1-9]|[12]\d|3[01])\d[A-Z0-9]{3}[A-Z]{2}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9YO870043187XXKN\u00E3l"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "Y" (seq.++ "O" (seq.++ "8" (seq.++ "7" (seq.++ "0" (seq.++ "0" (seq.++ "4" (seq.++ "3" (seq.++ "1" (seq.++ "8" (seq.++ "7" (seq.++ "X" (seq.++ "X" (seq.++ "K" (seq.++ "N" (seq.++ "\xe3" (seq.++ "l" "")))))))))))))))))))
;witness2: "99W88909314884WF"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "9" (seq.++ "W" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "0" (seq.++ "9" (seq.++ "3" (seq.++ "1" (seq.++ "4" (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "W" (seq.++ "F" "")))))))))))))))))

(assert (= regexA (re.++ ((_ re.loop 5 5) (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "0" "1") (re.range "5" "6"))(re.++ (re.range "0" "9")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range "0" "9")(re.++ ((_ re.loop 3 3) (re.union (re.range "0" "9") (re.range "A" "Z"))) ((_ re.loop 2 2) (re.range "A" "Z")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
