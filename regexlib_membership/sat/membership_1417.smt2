;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]{5}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "49987"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "7" ""))))))
;witness2: "96905"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "6" (seq.++ "9" (seq.++ "0" (seq.++ "5" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.range "0" "9")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
