;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d\d?\d?\.\d\d?\d?\.\d\d?\d?\.\d\d?\d?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "t2.20.90.18\u00FF\x2]\x1C\u00B3"
(define-fun Witness1 () String (seq.++ "t" (seq.++ "2" (seq.++ "." (seq.++ "2" (seq.++ "0" (seq.++ "." (seq.++ "9" (seq.++ "0" (seq.++ "." (seq.++ "1" (seq.++ "8" (seq.++ "\xff" (seq.++ "\x02" (seq.++ "]" (seq.++ "\x1c" (seq.++ "\xb3" "")))))))))))))))))
;witness2: "98.99.89.7<i\u0096"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "8" (seq.++ "." (seq.++ "9" (seq.++ "9" (seq.++ "." (seq.++ "8" (seq.++ "9" (seq.++ "." (seq.++ "7" (seq.++ "<" (seq.++ "i" (seq.++ "\x96" ""))))))))))))))

(assert (= regexA (re.++ (re.range "0" "9")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "0" "9")) (re.opt (re.range "0" "9"))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
