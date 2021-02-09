;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^-?([1-8]?[1-9]|[1-9]0)\.{1}\d{1,6}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "-88.3398"
(define-fun Witness1 () String (seq.++ "-" (seq.++ "8" (seq.++ "8" (seq.++ "." (seq.++ "3" (seq.++ "3" (seq.++ "9" (seq.++ "8" "")))))))))
;witness2: "-6.2\u00A8E"
(define-fun Witness2 () String (seq.++ "-" (seq.++ "6" (seq.++ "." (seq.++ "2" (seq.++ "\xa8" (seq.++ "E" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "-" "-"))(re.++ (re.union (re.++ (re.opt (re.range "1" "8")) (re.range "1" "9")) (re.++ (re.range "1" "9") (re.range "0" "0")))(re.++ (re.range "." ".") ((_ re.loop 1 6) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
