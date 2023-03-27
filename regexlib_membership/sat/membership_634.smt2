;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[2-5](2|4|6|8|0)(A(A)?|B|C|D(D(D)?)?|E|F|G|H)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "28AA"
(define-fun Witness1 () String (str.++ "2" (str.++ "8" (str.++ "A" (str.++ "A" "")))))
;witness2: "52H"
(define-fun Witness2 () String (str.++ "5" (str.++ "2" (str.++ "H" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "2" "5")(re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))))(re.++ (re.union (re.++ (re.range "A" "A") (re.opt (re.range "A" "A")))(re.union (re.range "B" "C")(re.union (re.++ (re.range "D" "D") (re.opt (re.++ (re.range "D" "D") (re.opt (re.range "D" "D"))))) (re.range "E" "H")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
