;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{9}[\d|X]$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "756091888|"
(define-fun Witness1 () String (str.++ "7" (str.++ "5" (str.++ "6" (str.++ "0" (str.++ "9" (str.++ "1" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "|" "")))))))))))
;witness2: "199898998|"
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "|" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 9 9) (re.range "0" "9"))(re.++ (re.union (re.range "0" "9")(re.union (re.range "X" "X") (re.range "|" "|"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
