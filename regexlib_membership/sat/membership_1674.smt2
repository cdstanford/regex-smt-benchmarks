;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([0-2]*[0-9]+[0-9]+)\.([0-2]*[0-9]+[0-9]+)\.([0-2]*[0-9]+[0-9]+)\.([0-2]*[0-9]+[0-9]+))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "792.2021888.0485819.20848"
(define-fun Witness1 () String (str.++ "7" (str.++ "9" (str.++ "2" (str.++ "." (str.++ "2" (str.++ "0" (str.++ "2" (str.++ "1" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "." (str.++ "0" (str.++ "4" (str.++ "8" (str.++ "5" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "." (str.++ "2" (str.++ "0" (str.++ "8" (str.++ "4" (str.++ "8" ""))))))))))))))))))))))))))
;witness2: "299.294659.1880.10188828"
(define-fun Witness2 () String (str.++ "2" (str.++ "9" (str.++ "9" (str.++ "." (str.++ "2" (str.++ "9" (str.++ "4" (str.++ "6" (str.++ "5" (str.++ "9" (str.++ "." (str.++ "1" (str.++ "8" (str.++ "8" (str.++ "0" (str.++ "." (str.++ "1" (str.++ "0" (str.++ "1" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "2" (str.++ "8" "")))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.++ (re.* (re.range "0" "2"))(re.++ (re.+ (re.range "0" "9")) (re.+ (re.range "0" "9"))))(re.++ (re.range "." ".")(re.++ (re.++ (re.* (re.range "0" "2"))(re.++ (re.+ (re.range "0" "9")) (re.+ (re.range "0" "9"))))(re.++ (re.range "." ".")(re.++ (re.++ (re.* (re.range "0" "2"))(re.++ (re.+ (re.range "0" "9")) (re.+ (re.range "0" "9"))))(re.++ (re.range "." ".") (re.++ (re.* (re.range "0" "2"))(re.++ (re.+ (re.range "0" "9")) (re.+ (re.range "0" "9")))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
