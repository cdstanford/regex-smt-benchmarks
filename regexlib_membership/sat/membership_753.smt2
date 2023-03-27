;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^N[1-9][0-9]{0,4}$|^N[1-9][0-9]{0,3}[A-Z]$|^N[1-9][0-9]{0,2}[A-Z]{2}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "N381ZV"
(define-fun Witness1 () String (str.++ "N" (str.++ "3" (str.++ "8" (str.++ "1" (str.++ "Z" (str.++ "V" "")))))))
;witness2: "N9989"
(define-fun Witness2 () String (str.++ "N" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "9" ""))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "N" "N")(re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 4) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.range "N" "N")(re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 3) (re.range "0" "9"))(re.++ (re.range "A" "Z") (str.to_re "")))))) (re.++ (str.to_re "")(re.++ (re.range "N" "N")(re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 2) (re.range "0" "9"))(re.++ ((_ re.loop 2 2) (re.range "A" "Z")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
