;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9a-fA-F]{4}|0)(\:([0-9a-fA-F]{4}|0)){7}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "4988:b07C:0:0:0:5D9F:0:0"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ ":" (seq.++ "b" (seq.++ "0" (seq.++ "7" (seq.++ "C" (seq.++ ":" (seq.++ "0" (seq.++ ":" (seq.++ "0" (seq.++ ":" (seq.++ "0" (seq.++ ":" (seq.++ "5" (seq.++ "D" (seq.++ "9" (seq.++ "F" (seq.++ ":" (seq.++ "0" (seq.++ ":" (seq.++ "0" "")))))))))))))))))))))))))
;witness2: "f98a:8843:0:8DA5:0:4498:0:8cb8"
(define-fun Witness2 () String (seq.++ "f" (seq.++ "9" (seq.++ "8" (seq.++ "a" (seq.++ ":" (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "3" (seq.++ ":" (seq.++ "0" (seq.++ ":" (seq.++ "8" (seq.++ "D" (seq.++ "A" (seq.++ "5" (seq.++ ":" (seq.++ "0" (seq.++ ":" (seq.++ "4" (seq.++ "4" (seq.++ "9" (seq.++ "8" (seq.++ ":" (seq.++ "0" (seq.++ ":" (seq.++ "8" (seq.++ "c" (seq.++ "b" (seq.++ "8" "")))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range "0" "0"))(re.++ ((_ re.loop 7 7) (re.++ (re.range ":" ":") (re.union ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range "0" "0")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
