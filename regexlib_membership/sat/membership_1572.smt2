;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z]{6}[0-9]{2}[A-Za-z]{1}[0-9]{2}[A-Za-z]{1}[0-9]{3}[A-Za-z]{1}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "PtKfcu01j55n998V"
(define-fun Witness1 () String (str.++ "P" (str.++ "t" (str.++ "K" (str.++ "f" (str.++ "c" (str.++ "u" (str.++ "0" (str.++ "1" (str.++ "j" (str.++ "5" (str.++ "5" (str.++ "n" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "V" "")))))))))))))))))
;witness2: "DrSzOs96t74c889z"
(define-fun Witness2 () String (str.++ "D" (str.++ "r" (str.++ "S" (str.++ "z" (str.++ "O" (str.++ "s" (str.++ "9" (str.++ "6" (str.++ "t" (str.++ "7" (str.++ "4" (str.++ "c" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "z" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 6 6) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
