;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9a-fA-F]){8}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "BDA27cEf"
(define-fun Witness1 () String (seq.++ "B" (seq.++ "D" (seq.++ "A" (seq.++ "2" (seq.++ "7" (seq.++ "c" (seq.++ "E" (seq.++ "f" "")))))))))
;witness2: "5fE8Fcfd"
(define-fun Witness2 () String (seq.++ "5" (seq.++ "f" (seq.++ "E" (seq.++ "8" (seq.++ "F" (seq.++ "c" (seq.++ "f" (seq.++ "d" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
