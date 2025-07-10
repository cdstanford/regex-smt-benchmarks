;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]{3}[uU]{1}[0-9]{7}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Sdqu9943888"
(define-fun Witness1 () String (str.++ "S" (str.++ "d" (str.++ "q" (str.++ "u" (str.++ "9" (str.++ "9" (str.++ "4" (str.++ "3" (str.++ "8" (str.++ "8" (str.++ "8" ""))))))))))))
;witness2: "XpUU8980109"
(define-fun Witness2 () String (str.++ "X" (str.++ "p" (str.++ "U" (str.++ "U" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "1" (str.++ "0" (str.++ "9" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.union (re.range "U" "U") (re.range "u" "u"))(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
