;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((0[1-9])|(1[0-2]))\/(([0-9])|([0-2][0-9])|(3[0-1]))/\d{2}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x1B08/30/98\u0083"
(define-fun Witness1 () String (seq.++ "\x1b" (seq.++ "0" (seq.++ "8" (seq.++ "/" (seq.++ "3" (seq.++ "0" (seq.++ "/" (seq.++ "9" (seq.++ "8" (seq.++ "\x83" "")))))))))))
;witness2: "12/9/91\u00C3\u00BD\u00B1\u00E9"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "2" (seq.++ "/" (seq.++ "9" (seq.++ "/" (seq.++ "9" (seq.++ "1" (seq.++ "\xc3" (seq.++ "\xbd" (seq.++ "\xb1" (seq.++ "\xe9" ""))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "/" "/")(re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range "/" "/") ((_ re.loop 2 2) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
