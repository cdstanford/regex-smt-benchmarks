;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[SFTG]\d{7}[A-Z]$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "G8808878Y"
(define-fun Witness1 () String (str.++ "G" (str.++ "8" (str.++ "8" (str.++ "0" (str.++ "8" (str.++ "8" (str.++ "7" (str.++ "8" (str.++ "Y" ""))))))))))
;witness2: "G4069633E"
(define-fun Witness2 () String (str.++ "G" (str.++ "4" (str.++ "0" (str.++ "6" (str.++ "9" (str.++ "6" (str.++ "3" (str.++ "3" (str.++ "E" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "F" "G") (re.range "S" "T"))(re.++ ((_ re.loop 7 7) (re.range "0" "9"))(re.++ (re.range "A" "Z") (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
