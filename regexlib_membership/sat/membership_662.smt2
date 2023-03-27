;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z]{3}(\d|[A-Z]){8,12}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "AARK8ZY44HZX"
(define-fun Witness1 () String (str.++ "A" (str.++ "A" (str.++ "R" (str.++ "K" (str.++ "8" (str.++ "Z" (str.++ "Y" (str.++ "4" (str.++ "4" (str.++ "H" (str.++ "Z" (str.++ "X" "")))))))))))))
;witness2: "TCXU9841XZ8WXV"
(define-fun Witness2 () String (str.++ "T" (str.++ "C" (str.++ "X" (str.++ "U" (str.++ "9" (str.++ "8" (str.++ "4" (str.++ "1" (str.++ "X" (str.++ "Z" (str.++ "8" (str.++ "W" (str.++ "X" (str.++ "V" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.range "A" "Z"))(re.++ ((_ re.loop 8 12) (re.union (re.range "0" "9") (re.range "A" "Z"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
