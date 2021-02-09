;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\d{3}\x2E\d{3}\x2E\d{3}\x2D\d{2}$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "319.592.814-58"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "1" (seq.++ "9" (seq.++ "." (seq.++ "5" (seq.++ "9" (seq.++ "2" (seq.++ "." (seq.++ "8" (seq.++ "1" (seq.++ "4" (seq.++ "-" (seq.++ "5" (seq.++ "8" "")))))))))))))))
;witness2: "789.369.905-18"
(define-fun Witness2 () String (seq.++ "7" (seq.++ "8" (seq.++ "9" (seq.++ "." (seq.++ "3" (seq.++ "6" (seq.++ "9" (seq.++ "." (seq.++ "9" (seq.++ "0" (seq.++ "5" (seq.++ "-" (seq.++ "1" (seq.++ "8" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
