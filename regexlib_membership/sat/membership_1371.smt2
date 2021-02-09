;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = 12/err
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "|\u009412/err"
(define-fun Witness1 () String (seq.++ "|" (seq.++ "\x94" (seq.++ "1" (seq.++ "2" (seq.++ "/" (seq.++ "e" (seq.++ "r" (seq.++ "r" "")))))))))
;witness2: "12/err"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "2" (seq.++ "/" (seq.++ "e" (seq.++ "r" (seq.++ "r" "")))))))

(assert (= regexA (str.to_re (seq.++ "1" (seq.++ "2" (seq.++ "/" (seq.++ "e" (seq.++ "r" (seq.++ "r" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
