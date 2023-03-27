;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[B|K|T|P][A-Z][0-9]{4}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "|A7288"
(define-fun Witness1 () String (str.++ "|" (str.++ "A" (str.++ "7" (str.++ "2" (str.++ "8" (str.++ "8" "")))))))
;witness2: "|C8584"
(define-fun Witness2 () String (str.++ "|" (str.++ "C" (str.++ "8" (str.++ "5" (str.++ "8" (str.++ "4" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "B" "B")(re.union (re.range "K" "K")(re.union (re.range "P" "P")(re.union (re.range "T" "T") (re.range "|" "|")))))(re.++ (re.range "A" "Z")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
