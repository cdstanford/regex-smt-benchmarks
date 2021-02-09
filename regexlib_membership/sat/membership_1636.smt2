;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(#){1}([a-fA-F0-9]){6}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "#8D9CAc"
(define-fun Witness1 () String (seq.++ "#" (seq.++ "8" (seq.++ "D" (seq.++ "9" (seq.++ "C" (seq.++ "A" (seq.++ "c" ""))))))))
;witness2: "#8ff5C8"
(define-fun Witness2 () String (seq.++ "#" (seq.++ "8" (seq.++ "f" (seq.++ "f" (seq.++ "5" (seq.++ "C" (seq.++ "8" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "#" "#")(re.++ ((_ re.loop 6 6) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
