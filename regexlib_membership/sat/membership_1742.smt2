;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z]{2}[0-9]{6}[A-DFM]{1}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "HC962849A"
(define-fun Witness1 () String (str.++ "H" (str.++ "C" (str.++ "9" (str.++ "6" (str.++ "2" (str.++ "8" (str.++ "4" (str.++ "9" (str.++ "A" ""))))))))))
;witness2: "FE980783M"
(define-fun Witness2 () String (str.++ "F" (str.++ "E" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "7" (str.++ "8" (str.++ "3" (str.++ "M" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.range "A" "Z"))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.union (re.range "A" "D")(re.union (re.range "F" "F") (re.range "M" "M"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
