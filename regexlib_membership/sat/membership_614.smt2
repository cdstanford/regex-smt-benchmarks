;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [1-8][0-9]{2}[0-9]{5}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "80984383"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "0" (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "3" (seq.++ "8" (seq.++ "3" "")))))))))
;witness2: "\u00F518081499\u00CA\u00BC"
(define-fun Witness2 () String (seq.++ "\xf5" (seq.++ "1" (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ "1" (seq.++ "4" (seq.++ "9" (seq.++ "9" (seq.++ "\xca" (seq.++ "\xbc" ""))))))))))))

(assert (= regexA (re.++ (re.range "1" "8")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) ((_ re.loop 5 5) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
