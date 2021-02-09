;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d{2}[.]{1}\d{2}[.]{1}[0-9A-Za-z]{1}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x6B60.69.8"
(define-fun Witness1 () String (seq.++ "\x06" (seq.++ "B" (seq.++ "6" (seq.++ "0" (seq.++ "." (seq.++ "6" (seq.++ "9" (seq.++ "." (seq.++ "8" ""))))))))))
;witness2: "Ff:\u00C4\u008985.14.x"
(define-fun Witness2 () String (seq.++ "F" (seq.++ "f" (seq.++ ":" (seq.++ "\xc4" (seq.++ "\x89" (seq.++ "8" (seq.++ "5" (seq.++ "." (seq.++ "1" (seq.++ "4" (seq.++ "." (seq.++ "x" "")))))))))))))

(assert (= regexA (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "." ".") (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
