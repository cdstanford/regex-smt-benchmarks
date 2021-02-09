;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\+){1}91){1}[1-9]{1}[0-9]{9}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+918484979328"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "9" (seq.++ "1" (seq.++ "8" (seq.++ "4" (seq.++ "8" (seq.++ "4" (seq.++ "9" (seq.++ "7" (seq.++ "9" (seq.++ "3" (seq.++ "2" (seq.++ "8" ""))))))))))))))
;witness2: "+914189412588"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "9" (seq.++ "1" (seq.++ "4" (seq.++ "1" (seq.++ "8" (seq.++ "9" (seq.++ "4" (seq.++ "1" (seq.++ "2" (seq.++ "5" (seq.++ "8" (seq.++ "8" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.range "+" "+") (str.to_re (seq.++ "9" (seq.++ "1" ""))))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
