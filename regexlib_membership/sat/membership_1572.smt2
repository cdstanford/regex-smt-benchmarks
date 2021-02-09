;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z]{6}[0-9]{2}[A-Za-z]{1}[0-9]{2}[A-Za-z]{1}[0-9]{3}[A-Za-z]{1}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "PtKfcu01j55n998V"
(define-fun Witness1 () String (seq.++ "P" (seq.++ "t" (seq.++ "K" (seq.++ "f" (seq.++ "c" (seq.++ "u" (seq.++ "0" (seq.++ "1" (seq.++ "j" (seq.++ "5" (seq.++ "5" (seq.++ "n" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "V" "")))))))))))))))))
;witness2: "DrSzOs96t74c889z"
(define-fun Witness2 () String (seq.++ "D" (seq.++ "r" (seq.++ "S" (seq.++ "z" (seq.++ "O" (seq.++ "s" (seq.++ "9" (seq.++ "6" (seq.++ "t" (seq.++ "7" (seq.++ "4" (seq.++ "c" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "z" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 6 6) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
