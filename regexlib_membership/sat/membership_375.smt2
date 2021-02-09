;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]{4}\d{6}[a-zA-Z]{6}\d{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "dJxE567898sxAajG65"
(define-fun Witness1 () String (seq.++ "d" (seq.++ "J" (seq.++ "x" (seq.++ "E" (seq.++ "5" (seq.++ "6" (seq.++ "7" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "s" (seq.++ "x" (seq.++ "A" (seq.++ "a" (seq.++ "j" (seq.++ "G" (seq.++ "6" (seq.++ "5" "")))))))))))))))))))
;witness2: "JezN889984gznrVP93"
(define-fun Witness2 () String (seq.++ "J" (seq.++ "e" (seq.++ "z" (seq.++ "N" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "g" (seq.++ "z" (seq.++ "n" (seq.++ "r" (seq.++ "V" (seq.++ "P" (seq.++ "9" (seq.++ "3" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ ((_ re.loop 6 6) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
