;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\(0[1-9]{1}\)[0-9]{8}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(08)92832990"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "0" (seq.++ "8" (seq.++ ")" (seq.++ "9" (seq.++ "2" (seq.++ "8" (seq.++ "3" (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "0" "")))))))))))))
;witness2: "(01)78988088"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "0" (seq.++ "1" (seq.++ ")" (seq.++ "7" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ "8" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "(" (seq.++ "0" "")))(re.++ (re.range "1" "9")(re.++ (re.range ")" ")")(re.++ ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
