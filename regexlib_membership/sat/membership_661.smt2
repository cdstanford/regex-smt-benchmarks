;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^R(\d){8}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "R88354924\u0086"
(define-fun Witness1 () String (seq.++ "R" (seq.++ "8" (seq.++ "8" (seq.++ "3" (seq.++ "5" (seq.++ "4" (seq.++ "9" (seq.++ "2" (seq.++ "4" (seq.++ "\x86" "")))))))))))
;witness2: "R98939613"
(define-fun Witness2 () String (seq.++ "R" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ "6" (seq.++ "1" (seq.++ "3" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "R" "R") ((_ re.loop 8 8) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
