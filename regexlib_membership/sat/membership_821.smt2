;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]{3}[-|/]{1}[0-9]{6}[-|/]{1}[0-9]{6}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "942/789891-968485"
(define-fun Witness1 () String (str.++ "9" (str.++ "4" (str.++ "2" (str.++ "/" (str.++ "7" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "1" (str.++ "-" (str.++ "9" (str.++ "6" (str.++ "8" (str.++ "4" (str.++ "8" (str.++ "5" ""))))))))))))))))))
;witness2: "081-995993|885639"
(define-fun Witness2 () String (str.++ "0" (str.++ "8" (str.++ "1" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "5" (str.++ "9" (str.++ "9" (str.++ "3" (str.++ "|" (str.++ "8" (str.++ "8" (str.++ "5" (str.++ "6" (str.++ "3" (str.++ "9" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "-" "-")(re.union (re.range "/" "/") (re.range "|" "|")))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.union (re.range "-" "-")(re.union (re.range "/" "/") (re.range "|" "|")))(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
