;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^#?(([a-fA-F0-9]{3}){1,2})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "#AFb"
(define-fun Witness1 () String (seq.++ "#" (seq.++ "A" (seq.++ "F" (seq.++ "b" "")))))
;witness2: "f80959"
(define-fun Witness2 () String (seq.++ "f" (seq.++ "8" (seq.++ "0" (seq.++ "9" (seq.++ "5" (seq.++ "9" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "#" "#"))(re.++ ((_ re.loop 1 2) ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
