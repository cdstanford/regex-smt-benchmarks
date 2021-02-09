;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+[0-9]{2,}[0-9]{4,}[0-9]*)(x?[0-9]{1,})?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+9938842899"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "9" (seq.++ "9" (seq.++ "3" (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "9" ""))))))))))))
;witness2: "+2993068"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "3" (seq.++ "0" (seq.++ "6" (seq.++ "8" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.range "+" "+")(re.++ (re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.* (re.range "0" "9")))(re.++ (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.* (re.range "0" "9"))) (re.* (re.range "0" "9")))))(re.++ (re.opt (re.++ (re.opt (re.range "x" "x")) (re.+ (re.range "0" "9")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
