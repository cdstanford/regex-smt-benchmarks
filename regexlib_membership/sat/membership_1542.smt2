;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[D-d][K-k]-[1-9]{1}[0-9]{3}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Kk-9898"
(define-fun Witness1 () String (seq.++ "K" (seq.++ "k" (seq.++ "-" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "8" ""))))))))
;witness2: "PM-3618"
(define-fun Witness2 () String (seq.++ "P" (seq.++ "M" (seq.++ "-" (seq.++ "3" (seq.++ "6" (seq.++ "1" (seq.++ "8" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "D" "d")(re.++ (re.range "K" "k")(re.++ (re.range "-" "-")(re.++ (re.range "1" "9")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
