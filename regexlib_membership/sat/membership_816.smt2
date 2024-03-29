;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[ISBN]{4}[ ]{0,1}[0-9]{1}[-]{1}[0-9]{3}[-]{1}[0-9]{5}[-]{1}[0-9]{0,1}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "NBNS 9-877-69877-2"
(define-fun Witness1 () String (str.++ "N" (str.++ "B" (str.++ "N" (str.++ "S" (str.++ " " (str.++ "9" (str.++ "-" (str.++ "8" (str.++ "7" (str.++ "7" (str.++ "-" (str.++ "6" (str.++ "9" (str.++ "8" (str.++ "7" (str.++ "7" (str.++ "-" (str.++ "2" "")))))))))))))))))))
;witness2: "NISS 2-986-38524-8"
(define-fun Witness2 () String (str.++ "N" (str.++ "I" (str.++ "S" (str.++ "S" (str.++ " " (str.++ "2" (str.++ "-" (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "-" (str.++ "3" (str.++ "8" (str.++ "5" (str.++ "2" (str.++ "4" (str.++ "-" (str.++ "8" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.union (re.range "B" "B")(re.union (re.range "I" "I")(re.union (re.range "N" "N") (re.range "S" "S")))))(re.++ (re.opt (re.range " " " "))(re.++ (re.range "0" "9")(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.opt (re.range "0" "9")) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
