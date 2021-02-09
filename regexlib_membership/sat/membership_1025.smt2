;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(BE){0,1}[0]{0,1}[0-9]{9}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "BE832295091"
(define-fun Witness1 () String (seq.++ "B" (seq.++ "E" (seq.++ "8" (seq.++ "3" (seq.++ "2" (seq.++ "2" (seq.++ "9" (seq.++ "5" (seq.++ "0" (seq.++ "9" (seq.++ "1" ""))))))))))))
;witness2: "286193060"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "8" (seq.++ "6" (seq.++ "1" (seq.++ "9" (seq.++ "3" (seq.++ "0" (seq.++ "6" (seq.++ "0" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (seq.++ "B" (seq.++ "E" ""))))(re.++ (re.opt (re.range "0" "0"))(re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
