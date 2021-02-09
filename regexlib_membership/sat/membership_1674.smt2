;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([0-2]*[0-9]+[0-9]+)\.([0-2]*[0-9]+[0-9]+)\.([0-2]*[0-9]+[0-9]+)\.([0-2]*[0-9]+[0-9]+))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "792.2021888.0485819.20848"
(define-fun Witness1 () String (seq.++ "7" (seq.++ "9" (seq.++ "2" (seq.++ "." (seq.++ "2" (seq.++ "0" (seq.++ "2" (seq.++ "1" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "." (seq.++ "0" (seq.++ "4" (seq.++ "8" (seq.++ "5" (seq.++ "8" (seq.++ "1" (seq.++ "9" (seq.++ "." (seq.++ "2" (seq.++ "0" (seq.++ "8" (seq.++ "4" (seq.++ "8" ""))))))))))))))))))))))))))
;witness2: "299.294659.1880.10188828"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "." (seq.++ "2" (seq.++ "9" (seq.++ "4" (seq.++ "6" (seq.++ "5" (seq.++ "9" (seq.++ "." (seq.++ "1" (seq.++ "8" (seq.++ "8" (seq.++ "0" (seq.++ "." (seq.++ "1" (seq.++ "0" (seq.++ "1" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "2" (seq.++ "8" "")))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.++ (re.* (re.range "0" "2"))(re.++ (re.+ (re.range "0" "9")) (re.+ (re.range "0" "9"))))(re.++ (re.range "." ".")(re.++ (re.++ (re.* (re.range "0" "2"))(re.++ (re.+ (re.range "0" "9")) (re.+ (re.range "0" "9"))))(re.++ (re.range "." ".")(re.++ (re.++ (re.* (re.range "0" "2"))(re.++ (re.+ (re.range "0" "9")) (re.+ (re.range "0" "9"))))(re.++ (re.range "." ".") (re.++ (re.* (re.range "0" "2"))(re.++ (re.+ (re.range "0" "9")) (re.+ (re.range "0" "9")))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
