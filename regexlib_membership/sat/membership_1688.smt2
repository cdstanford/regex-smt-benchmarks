;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\d{3}\x2E\d{3}\x2E\d{3}\x2D\d{2}$)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "319.592.814-58"
(define-fun Witness1 () String (str.++ "3" (str.++ "1" (str.++ "9" (str.++ "." (str.++ "5" (str.++ "9" (str.++ "2" (str.++ "." (str.++ "8" (str.++ "1" (str.++ "4" (str.++ "-" (str.++ "5" (str.++ "8" "")))))))))))))))
;witness2: "789.369.905-18"
(define-fun Witness2 () String (str.++ "7" (str.++ "8" (str.++ "9" (str.++ "." (str.++ "3" (str.++ "6" (str.++ "9" (str.++ "." (str.++ "9" (str.++ "0" (str.++ "5" (str.++ "-" (str.++ "1" (str.++ "8" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
