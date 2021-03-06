;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z]{3,4}[0-9]{6}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "zONo989999"
(define-fun Witness1 () String (seq.++ "z" (seq.++ "O" (seq.++ "N" (seq.++ "o" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "9" "")))))))))))
;witness2: "JThZ380954"
(define-fun Witness2 () String (seq.++ "J" (seq.++ "T" (seq.++ "h" (seq.++ "Z" (seq.++ "3" (seq.++ "8" (seq.++ "0" (seq.++ "9" (seq.++ "5" (seq.++ "4" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 4) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
