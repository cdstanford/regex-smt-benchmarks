;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^-?([1-8]?[1-9]|[1-9]0)\.{1}\d{1,6}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-88.3398"
(define-fun Witness1 () String (str.++ "-" (str.++ "8" (str.++ "8" (str.++ "." (str.++ "3" (str.++ "3" (str.++ "9" (str.++ "8" "")))))))))
;witness2: "-6.2\u00A8E"
(define-fun Witness2 () String (str.++ "-" (str.++ "6" (str.++ "." (str.++ "2" (str.++ "\u{a8}" (str.++ "E" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "-" "-"))(re.++ (re.union (re.++ (re.opt (re.range "1" "8")) (re.range "1" "9")) (re.++ (re.range "1" "9") (re.range "0" "0")))(re.++ (re.range "." ".") ((_ re.loop 1 6) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
