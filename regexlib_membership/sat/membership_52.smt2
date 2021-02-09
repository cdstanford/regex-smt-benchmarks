;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^#[\dA-Fa-f]{3}(?:[\dA-Fa-f]{3}[\dA-Fa-f]{0,2})?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "#bFa8E2a"
(define-fun Witness1 () String (seq.++ "#" (seq.++ "b" (seq.++ "F" (seq.++ "a" (seq.++ "8" (seq.++ "E" (seq.++ "2" (seq.++ "a" "")))))))))
;witness2: "#9cE9ff"
(define-fun Witness2 () String (seq.++ "#" (seq.++ "9" (seq.++ "c" (seq.++ "E" (seq.++ "9" (seq.++ "f" (seq.++ "f" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "#" "#")(re.++ ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.++ ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) ((_ re.loop 0 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
