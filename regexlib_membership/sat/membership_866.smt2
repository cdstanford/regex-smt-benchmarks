;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0]?\d|1\d|2[0-3]):([0-5]\d):([0-5]\d)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "3:48:22"
(define-fun Witness1 () String (seq.++ "3" (seq.++ ":" (seq.++ "4" (seq.++ "8" (seq.++ ":" (seq.++ "2" (seq.++ "2" ""))))))))
;witness2: "5:38:45"
(define-fun Witness2 () String (seq.++ "5" (seq.++ ":" (seq.++ "3" (seq.++ "8" (seq.++ ":" (seq.++ "4" (seq.++ "5" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
