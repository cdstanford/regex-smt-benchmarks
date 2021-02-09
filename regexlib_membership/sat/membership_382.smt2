;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]{10}GBR[0-9]{7}[U,M,F]{1}[0-9]{9}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "7578198299GBR9348509,286098889"
(define-fun Witness1 () String (seq.++ "7" (seq.++ "5" (seq.++ "7" (seq.++ "8" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "G" (seq.++ "B" (seq.++ "R" (seq.++ "9" (seq.++ "3" (seq.++ "4" (seq.++ "8" (seq.++ "5" (seq.++ "0" (seq.++ "9" (seq.++ "," (seq.++ "2" (seq.++ "8" (seq.++ "6" (seq.++ "0" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "9" "")))))))))))))))))))))))))))))))
;witness2: "9890288979GBR8899557,886938838"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "0" (seq.++ "2" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "7" (seq.++ "9" (seq.++ "G" (seq.++ "B" (seq.++ "R" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "5" (seq.++ "5" (seq.++ "7" (seq.++ "," (seq.++ "8" (seq.++ "8" (seq.++ "6" (seq.++ "9" (seq.++ "3" (seq.++ "8" (seq.++ "8" (seq.++ "3" (seq.++ "8" "")))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 10 10) (re.range "0" "9"))(re.++ (str.to_re (seq.++ "G" (seq.++ "B" (seq.++ "R" ""))))(re.++ ((_ re.loop 7 7) (re.range "0" "9"))(re.++ (re.union (re.range "," ",")(re.union (re.range "F" "F")(re.union (re.range "M" "M") (re.range "U" "U"))))(re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
