;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-z]?\d{8}[A-z]$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "z96929778r"
(define-fun Witness1 () String (seq.++ "z" (seq.++ "9" (seq.++ "6" (seq.++ "9" (seq.++ "2" (seq.++ "9" (seq.++ "7" (seq.++ "7" (seq.++ "8" (seq.++ "r" "")))))))))))
;witness2: "P67001843V"
(define-fun Witness2 () String (seq.++ "P" (seq.++ "6" (seq.++ "7" (seq.++ "0" (seq.++ "0" (seq.++ "1" (seq.++ "8" (seq.++ "4" (seq.++ "3" (seq.++ "V" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "A" "z"))(re.++ ((_ re.loop 8 8) (re.range "0" "9"))(re.++ (re.range "A" "z") (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
