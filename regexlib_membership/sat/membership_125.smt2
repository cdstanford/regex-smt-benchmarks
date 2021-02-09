;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[6]\d{7}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "64804288"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "4" (seq.++ "8" (seq.++ "0" (seq.++ "4" (seq.++ "2" (seq.++ "8" (seq.++ "8" "")))))))))
;witness2: "69199928"
(define-fun Witness2 () String (seq.++ "6" (seq.++ "9" (seq.++ "1" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "2" (seq.++ "8" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "6" "6")(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
