;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]{4}\d{6}[a-zA-Z]{6}\d{2}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "dJxE567898sxAajG65"
(define-fun Witness1 () String (str.++ "d" (str.++ "J" (str.++ "x" (str.++ "E" (str.++ "5" (str.++ "6" (str.++ "7" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "s" (str.++ "x" (str.++ "A" (str.++ "a" (str.++ "j" (str.++ "G" (str.++ "6" (str.++ "5" "")))))))))))))))))))
;witness2: "JezN889984gznrVP93"
(define-fun Witness2 () String (str.++ "J" (str.++ "e" (str.++ "z" (str.++ "N" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "4" (str.++ "g" (str.++ "z" (str.++ "n" (str.++ "r" (str.++ "V" (str.++ "P" (str.++ "9" (str.++ "3" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ ((_ re.loop 6 6) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
