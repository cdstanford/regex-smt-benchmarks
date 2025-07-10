;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [+-]*[0-9]+[,]*[0-9]*|[+-]*[0-9]*[,]+[0-9]*
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+9,95"
(define-fun Witness1 () String (str.++ "+" (str.++ "9" (str.++ "," (str.++ "9" (str.++ "5" ""))))))
;witness2: "\u00AC,3\u00E0"
(define-fun Witness2 () String (str.++ "\u{ac}" (str.++ "," (str.++ "3" (str.++ "\u{e0}" "")))))

(assert (= regexA (re.union (re.++ (re.* (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.* (re.range "," ",")) (re.* (re.range "0" "9"))))) (re.++ (re.* (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.+ (re.range "," ",")) (re.* (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
