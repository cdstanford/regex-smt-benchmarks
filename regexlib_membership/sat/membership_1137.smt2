;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(6553[0-5]|655[0-2]\d|65[0-4]\d\d|6[0-4]\d{3}|5\d{4}|49[2-9]\d\d|491[6-9]\d|4915[2-9])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "65534"
(define-fun Witness1 () String (str.++ "6" (str.++ "5" (str.++ "5" (str.++ "3" (str.++ "4" ""))))))
;witness2: "65504"
(define-fun Witness2 () String (str.++ "6" (str.++ "5" (str.++ "5" (str.++ "0" (str.++ "4" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (str.++ "6" (str.++ "5" (str.++ "5" (str.++ "3" ""))))) (re.range "0" "5"))(re.union (re.++ (str.to_re (str.++ "6" (str.++ "5" (str.++ "5" ""))))(re.++ (re.range "0" "2") (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "6" (str.++ "5" "")))(re.++ (re.range "0" "4")(re.++ (re.range "0" "9") (re.range "0" "9"))))(re.union (re.++ (re.range "6" "6")(re.++ (re.range "0" "4") ((_ re.loop 3 3) (re.range "0" "9"))))(re.union (re.++ (re.range "5" "5") ((_ re.loop 4 4) (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "4" (str.++ "9" "")))(re.++ (re.range "2" "9")(re.++ (re.range "0" "9") (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "4" (str.++ "9" (str.++ "1" ""))))(re.++ (re.range "6" "9") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "4" (str.++ "9" (str.++ "1" (str.++ "5" ""))))) (re.range "2" "9"))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
