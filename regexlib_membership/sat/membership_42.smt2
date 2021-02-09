;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = sdgsdf
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00EA\u00B1tfsdgsdf\u00FA"
(define-fun Witness1 () String (seq.++ "\xea" (seq.++ "\xb1" (seq.++ "t" (seq.++ "f" (seq.++ "s" (seq.++ "d" (seq.++ "g" (seq.++ "s" (seq.++ "d" (seq.++ "f" (seq.++ "\xfa" ""))))))))))))
;witness2: "sdgsdf"
(define-fun Witness2 () String (seq.++ "s" (seq.++ "d" (seq.++ "g" (seq.++ "s" (seq.++ "d" (seq.++ "f" "")))))))

(assert (= regexA (str.to_re (seq.++ "s" (seq.++ "d" (seq.++ "g" (seq.++ "s" (seq.++ "d" (seq.++ "f" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
