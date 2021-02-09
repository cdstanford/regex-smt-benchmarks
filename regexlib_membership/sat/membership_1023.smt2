;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(CZ){0,1}[0-9]{8,10}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "52769809"
(define-fun Witness1 () String (seq.++ "5" (seq.++ "2" (seq.++ "7" (seq.++ "6" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "9" "")))))))))
;witness2: "CZ868087089"
(define-fun Witness2 () String (seq.++ "C" (seq.++ "Z" (seq.++ "8" (seq.++ "6" (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ "7" (seq.++ "0" (seq.++ "8" (seq.++ "9" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (seq.++ "C" (seq.++ "Z" ""))))(re.++ ((_ re.loop 8 10) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
