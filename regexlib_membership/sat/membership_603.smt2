;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d+\.\d\.\d[01]\d[0-3]\d\.[1-9]\d*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "978.3.40028.88"
(define-fun Witness1 () String (str.++ "9" (str.++ "7" (str.++ "8" (str.++ "." (str.++ "3" (str.++ "." (str.++ "4" (str.++ "0" (str.++ "0" (str.++ "2" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "8" "")))))))))))))))
;witness2: "289.9.80835.8"
(define-fun Witness2 () String (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "." (str.++ "9" (str.++ "." (str.++ "8" (str.++ "0" (str.++ "8" (str.++ "3" (str.++ "5" (str.++ "." (str.++ "8" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.range "0" "9")(re.++ (re.range "." ".")(re.++ (re.range "0" "9")(re.++ (re.range "0" "1")(re.++ (re.range "0" "9")(re.++ (re.range "0" "3")(re.++ (re.range "0" "9")(re.++ (re.range "." ".")(re.++ (re.range "1" "9")(re.++ (re.* (re.range "0" "9")) (str.to_re ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
