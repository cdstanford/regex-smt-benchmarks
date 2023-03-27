;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-5]?\d?\d?\d?\d|6[0-4]\d\d\d|65[0-4]\d\d|655[0-2]\d|6553[0-5])$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "97"
(define-fun Witness1 () String (str.++ "9" (str.++ "7" "")))
;witness2: "65534"
(define-fun Witness2 () String (str.++ "6" (str.++ "5" (str.++ "5" (str.++ "3" (str.++ "4" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "0" "5"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9")) (re.range "0" "9")))))(re.union (re.++ (re.range "6" "6")(re.++ (re.range "0" "4")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9")))))(re.union (re.++ (str.to_re (str.++ "6" (str.++ "5" "")))(re.++ (re.range "0" "4")(re.++ (re.range "0" "9") (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "6" (str.++ "5" (str.++ "5" ""))))(re.++ (re.range "0" "2") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "6" (str.++ "5" (str.++ "5" (str.++ "3" ""))))) (re.range "0" "5")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
