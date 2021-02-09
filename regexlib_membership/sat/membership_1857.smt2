;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d*\.?((25)|(50)|(5)|(75)|(0)|(00))?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "37"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "7" "")))
;witness2: "98.25"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "8" (seq.++ "." (seq.++ "2" (seq.++ "5" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.opt (re.union (str.to_re (seq.++ "2" (seq.++ "5" "")))(re.union (str.to_re (seq.++ "5" (seq.++ "0" "")))(re.union (re.range "5" "5")(re.union (str.to_re (seq.++ "7" (seq.++ "5" "")))(re.union (re.range "0" "0") (str.to_re (seq.++ "0" (seq.++ "0" ""))))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
