;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]{3}[uU]{1}[0-9]{7}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Sdqu9943888"
(define-fun Witness1 () String (seq.++ "S" (seq.++ "d" (seq.++ "q" (seq.++ "u" (seq.++ "9" (seq.++ "9" (seq.++ "4" (seq.++ "3" (seq.++ "8" (seq.++ "8" (seq.++ "8" ""))))))))))))
;witness2: "XpUU8980109"
(define-fun Witness2 () String (seq.++ "X" (seq.++ "p" (seq.++ "U" (seq.++ "U" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "1" (seq.++ "0" (seq.++ "9" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.union (re.range "U" "U") (re.range "u" "u"))(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
