;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z]{3,4}[0-9]{6}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "zONo989999"
(define-fun Witness1 () String (str.++ "z" (str.++ "O" (str.++ "N" (str.++ "o" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "9" "")))))))))))
;witness2: "JThZ380954"
(define-fun Witness2 () String (str.++ "J" (str.++ "T" (str.++ "h" (str.++ "Z" (str.++ "3" (str.++ "8" (str.++ "0" (str.++ "9" (str.++ "5" (str.++ "4" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 4) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
