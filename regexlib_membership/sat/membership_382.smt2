;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]{10}GBR[0-9]{7}[U,M,F]{1}[0-9]{9}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "7578198299GBR9348509,286098889"
(define-fun Witness1 () String (str.++ "7" (str.++ "5" (str.++ "7" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "2" (str.++ "9" (str.++ "9" (str.++ "G" (str.++ "B" (str.++ "R" (str.++ "9" (str.++ "3" (str.++ "4" (str.++ "8" (str.++ "5" (str.++ "0" (str.++ "9" (str.++ "," (str.++ "2" (str.++ "8" (str.++ "6" (str.++ "0" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "9" "")))))))))))))))))))))))))))))))
;witness2: "9890288979GBR8899557,886938838"
(define-fun Witness2 () String (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "0" (str.++ "2" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "7" (str.++ "9" (str.++ "G" (str.++ "B" (str.++ "R" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "5" (str.++ "5" (str.++ "7" (str.++ "," (str.++ "8" (str.++ "8" (str.++ "6" (str.++ "9" (str.++ "3" (str.++ "8" (str.++ "8" (str.++ "3" (str.++ "8" "")))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 10 10) (re.range "0" "9"))(re.++ (str.to_re (str.++ "G" (str.++ "B" (str.++ "R" ""))))(re.++ ((_ re.loop 7 7) (re.range "0" "9"))(re.++ (re.union (re.range "," ",")(re.union (re.range "F" "F")(re.union (re.range "M" "M") (re.range "U" "U"))))(re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
