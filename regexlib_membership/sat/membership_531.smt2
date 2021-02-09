;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(AT){0,1}[U]{0,1}[0-9]{8}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "65992889"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ "2" (seq.++ "8" (seq.++ "8" (seq.++ "9" "")))))))))
;witness2: "AT83187446"
(define-fun Witness2 () String (seq.++ "A" (seq.++ "T" (seq.++ "8" (seq.++ "3" (seq.++ "1" (seq.++ "8" (seq.++ "7" (seq.++ "4" (seq.++ "4" (seq.++ "6" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (seq.++ "A" (seq.++ "T" ""))))(re.++ (re.opt (re.range "U" "U"))(re.++ ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
