;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [+-]*[0-9]+[,]*[0-9]*|[+-]*[0-9]*[,]+[0-9]*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+9,95"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "9" (seq.++ "," (seq.++ "9" (seq.++ "5" ""))))))
;witness2: "\u00AC,3\u00E0"
(define-fun Witness2 () String (seq.++ "\xac" (seq.++ "," (seq.++ "3" (seq.++ "\xe0" "")))))

(assert (= regexA (re.union (re.++ (re.* (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.* (re.range "," ",")) (re.* (re.range "0" "9"))))) (re.++ (re.* (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.+ (re.range "," ",")) (re.* (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
